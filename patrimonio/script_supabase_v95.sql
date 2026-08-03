-- =========================================================
-- SGP v95 - Complemento contábil dos bens patrimoniais
-- Execute no Supabase SQL Editor antes de usar os novos campos
-- =========================================================

create table if not exists public.bens_patrimoniais_ext (
  numero_patrimonial text primary key,
  nota_empenho text,
  categoria_principal text,
  categoria_secundaria text,
  depreciavel boolean not null default true,
  criado_em timestamp with time zone not null default now(),
  atualizado_em timestamp with time zone not null default now()
);

alter table public.bens_patrimoniais_ext enable row level security;

create or replace function public.set_atualizado_em()
returns trigger
language plpgsql
as $$
begin
  new.atualizado_em = now();
  return new;
end;
$$;

drop trigger if exists trg_bens_patrimoniais_ext_atualizado_em on public.bens_patrimoniais_ext;
create trigger trg_bens_patrimoniais_ext_atualizado_em
before update on public.bens_patrimoniais_ext
for each row
execute function public.set_atualizado_em();

drop policy if exists "bens_ext_select" on public.bens_patrimoniais_ext;
create policy "bens_ext_select"
on public.bens_patrimoniais_ext
for select
to authenticated
using (public.can_view());

drop policy if exists "bens_ext_insert" on public.bens_patrimoniais_ext;
create policy "bens_ext_insert"
on public.bens_patrimoniais_ext
for insert
to authenticated
with check (public.can_edit());

drop policy if exists "bens_ext_update" on public.bens_patrimoniais_ext;
create policy "bens_ext_update"
on public.bens_patrimoniais_ext
for update
to authenticated
using (public.can_edit())
with check (public.can_edit());

drop policy if exists "bens_ext_delete" on public.bens_patrimoniais_ext;
create policy "bens_ext_delete"
on public.bens_patrimoniais_ext
for delete
to authenticated
using (public.can_edit());
