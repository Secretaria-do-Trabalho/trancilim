-- ============================================================
-- TRANCELIM v142 — autenticação, perfis, aprovação e sininho
-- Execute este arquivo inteiro no SQL Editor do Supabase.
-- Projeto esperado: controle-patrimonial-set
-- ============================================================

begin;

create extension if not exists pgcrypto;

-- 1) Tabela pública de perfis vinculada ao Supabase Auth.
create table if not exists public.usuarios_perfis (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid references auth.users(id) on delete cascade,
  nome text,
  email text,
  setor text,
  perfil text default 'Usuário',
  permissao text default 'visualizar',
  status text default 'pendente',
  modulos text[] default '{}'::text[],
  modulo_solicitado text,
  justificativa text,
  is_admin boolean default false,
  foto_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  approved_at timestamptz,
  approved_by uuid references auth.users(id)
);

alter table public.usuarios_perfis add column if not exists auth_user_id uuid references auth.users(id) on delete cascade;
alter table public.usuarios_perfis add column if not exists nome text;
alter table public.usuarios_perfis add column if not exists email text;
alter table public.usuarios_perfis add column if not exists setor text;
alter table public.usuarios_perfis add column if not exists perfil text default 'Usuário';
alter table public.usuarios_perfis add column if not exists permissao text default 'visualizar';
alter table public.usuarios_perfis add column if not exists status text default 'pendente';
alter table public.usuarios_perfis add column if not exists modulos text[] default '{}'::text[];
alter table public.usuarios_perfis add column if not exists modulo_solicitado text;
alter table public.usuarios_perfis add column if not exists justificativa text;
alter table public.usuarios_perfis add column if not exists is_admin boolean default false;
alter table public.usuarios_perfis add column if not exists foto_url text;
alter table public.usuarios_perfis add column if not exists created_at timestamptz default now();
alter table public.usuarios_perfis add column if not exists updated_at timestamptz default now();
alter table public.usuarios_perfis add column if not exists approved_at timestamptz;
alter table public.usuarios_perfis add column if not exists approved_by uuid references auth.users(id);

-- Remove duplicidades de auth_user_id, se houver, antes de criar o índice único.
with repetidos as (
  select id,
         row_number() over (partition by auth_user_id order by created_at nulls last, id) as ordem
  from public.usuarios_perfis
  where auth_user_id is not null
)
delete from public.usuarios_perfis p
using repetidos r
where p.id = r.id and r.ordem > 1;

create unique index if not exists usuarios_perfis_auth_user_id_uidx
  on public.usuarios_perfis(auth_user_id)
  where auth_user_id is not null;

create index if not exists usuarios_perfis_status_idx
  on public.usuarios_perfis(status);

create index if not exists usuarios_perfis_email_idx
  on public.usuarios_perfis(lower(email));

-- 2) Atualização automática de updated_at.
create or replace function public.trancelim_set_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trancelim_usuarios_perfis_updated_at on public.usuarios_perfis;
create trigger trancelim_usuarios_perfis_updated_at
before update on public.usuarios_perfis
for each row execute function public.trancelim_set_updated_at();

-- 3) Cria o perfil pendente automaticamente quando alguém usa
--    "Solicitar cadastro" no portal.
create or replace function public.trancelim_handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.usuarios_perfis (
    auth_user_id,
    nome,
    email,
    setor,
    perfil,
    permissao,
    status,
    modulos,
    modulo_solicitado,
    justificativa,
    is_admin,
    created_at,
    updated_at
  )
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'nome', split_part(new.email, '@', 1)),
    lower(new.email),
    coalesce(new.raw_user_meta_data ->> 'setor', '-'),
    'Usuário',
    'visualizar',
    'pendente',
    '{}'::text[],
    nullif(new.raw_user_meta_data ->> 'modulo_solicitado', ''),
    nullif(new.raw_user_meta_data ->> 'justificativa', ''),
    false,
    now(),
    now()
  )
  on conflict (auth_user_id) do update set
    nome = excluded.nome,
    email = excluded.email,
    setor = excluded.setor,
    modulo_solicitado = excluded.modulo_solicitado,
    justificativa = excluded.justificativa,
    updated_at = now();

  return new;
end;
$$;

drop trigger if exists on_auth_user_created_trancelim on auth.users;
create trigger on_auth_user_created_trancelim
after insert on auth.users
for each row execute function public.trancelim_handle_new_user();

-- 4) Função segura usada pelas políticas para identificar o administrador.
create or replace function public.trancelim_is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.usuarios_perfis p
    where p.auth_user_id = auth.uid()
      and p.is_admin = true
      and p.status = 'aprovado'
  );
$$;

revoke all on function public.trancelim_is_admin() from public;
grant execute on function public.trancelim_is_admin() to authenticated;

-- 5) Segurança por linha (RLS).
alter table public.usuarios_perfis enable row level security;

drop policy if exists usuarios_perfis_select_proprio_ou_admin on public.usuarios_perfis;
create policy usuarios_perfis_select_proprio_ou_admin
on public.usuarios_perfis
for select
to authenticated
using (
  auth_user_id = auth.uid()
  or public.trancelim_is_admin()
);

drop policy if exists usuarios_perfis_update_admin on public.usuarios_perfis;
create policy usuarios_perfis_update_admin
on public.usuarios_perfis
for update
to authenticated
using (public.trancelim_is_admin())
with check (public.trancelim_is_admin());

drop policy if exists usuarios_perfis_delete_admin on public.usuarios_perfis;
create policy usuarios_perfis_delete_admin
on public.usuarios_perfis
for delete
to authenticated
using (public.trancelim_is_admin());

-- O cadastro público não insere diretamente na tabela: o trigger de auth.users
-- cria a linha com status pendente. Portanto não é necessária policy de INSERT anon.

grant select, update, delete on public.usuarios_perfis to authenticated;
revoke insert on public.usuarios_perfis from anon, authenticated;

-- 6) Vincula e aprova David como administrador, se o usuário já existir no Auth.
insert into public.usuarios_perfis (
  auth_user_id, nome, email, setor, perfil, permissao, status,
  modulos, is_admin, created_at, updated_at, approved_at
)
select
  u.id,
  'David Pereira Alcântara',
  lower(u.email),
  'COAFI',
  'Administrador',
  'total',
  'aprovado',
  array['patrimonio','prestacao-contas']::text[],
  true,
  now(),
  now(),
  now()
from auth.users u
where lower(u.email) = 'david.alcantara@trabalho.ce.gov.br'
on conflict (auth_user_id) do update set
  nome = excluded.nome,
  email = excluded.email,
  setor = excluded.setor,
  perfil = excluded.perfil,
  permissao = excluded.permissao,
  status = excluded.status,
  modulos = excluded.modulos,
  is_admin = true,
  approved_at = coalesce(public.usuarios_perfis.approved_at, now()),
  updated_at = now();

-- 7) Se Paula já existir no Supabase Auth, registra a solicitação pendente dela.
insert into public.usuarios_perfis (
  auth_user_id, nome, email, setor, perfil, permissao, status,
  modulos, modulo_solicitado, justificativa, is_admin, created_at, updated_at
)
select
  u.id,
  'Paula Carvalho',
  lower(u.email),
  'Patrimônio',
  'Usuário',
  'visualizar',
  'pendente',
  '{}'::text[],
  'patrimonio',
  'Solicitação de acesso ao Sistema de Gestão Patrimonial.',
  false,
  now(),
  now()
from auth.users u
where lower(u.email) = 'paula.carvalho@trabalho.ce.gov.br'
on conflict (auth_user_id) do update set
  nome = excluded.nome,
  email = excluded.email,
  setor = excluded.setor,
  modulo_solicitado = excluded.modulo_solicitado,
  justificativa = excluded.justificativa,
  status = case
    when public.usuarios_perfis.status = 'aprovado' then public.usuarios_perfis.status
    else 'pendente'
  end,
  updated_at = now();

commit;

-- ============================================================
-- CONFERÊNCIA: depois de executar, rode esta consulta separada.
-- ============================================================
select
  nome,
  email,
  setor,
  perfil,
  permissao,
  status,
  modulos,
  modulo_solicitado,
  is_admin,
  created_at
from public.usuarios_perfis
order by created_at desc;
