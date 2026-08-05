-- SGP v129 - Conferência/Ajuste da base para campos do cadastro por lote
-- Rode no Supabase SQL Editor. É seguro executar mais de uma vez.

alter table if exists public.bens_patrimoniais_ext
  add column if not exists codigo_item_catalogo text,
  add column if not exists justificativa_divergencia text,
  add column if not exists valor_entrada_nf numeric,
  add column if not exists valor_ne numeric,
  add column if not exists valor_of numeric,
  add column if not exists valor_itens numeric;

create unique index if not exists idx_bens_patrimoniais_ext_numero
on public.bens_patrimoniais_ext (numero_patrimonial);

select
  'Base conferida para v129: colunas de código catálogo/justificativa/valores disponíveis' as status,
  count(*) as total_registros_ext
from public.bens_patrimoniais_ext;
