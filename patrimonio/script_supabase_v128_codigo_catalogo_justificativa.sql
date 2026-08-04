-- SGP v128 - Campos do cadastro por lote
-- Rode no SQL Editor do Supabase para compartilhar esses dados entre todos os usuários.

alter table public.bens_patrimoniais_ext
  add column if not exists codigo_item_catalogo text,
  add column if not exists justificativa_divergencia text,
  add column if not exists valor_entrada_nf numeric(14,2),
  add column if not exists valor_ne numeric(14,2),
  add column if not exists valor_of numeric(14,2),
  add column if not exists valor_itens numeric(14,2);

select
  'Campos v128 criados/ajustados com sucesso' as status,
  count(*) as total_registros_ext
from public.bens_patrimoniais_ext;
