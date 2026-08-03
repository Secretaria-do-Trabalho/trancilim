-- SGP v123 - Limpar anexos duplicados e impedir duplicidade futura
-- Mantém somente o anexo mais recente de cada tipo em cada bem.
-- Não apaga arquivos do Storage; remove apenas registros duplicados da tabela.

with ranked as (
  select
    id,
    bem_id,
    tipo_anexo,
    row_number() over (
      partition by bem_id, tipo_anexo
      order by criado_em desc nulls last, id desc
    ) as rn
  from public.anexos_bens
)
delete from public.anexos_bens a
using ranked r
where a.id = r.id
  and r.rn > 1;

drop index if exists public.idx_anexos_bens_bem_tipo_unico;

create unique index if not exists idx_anexos_bens_bem_tipo_unico
on public.anexos_bens (bem_id, tipo_anexo);

select
  'Anexos duplicados limpos e índice único criado' as status,
  count(*) as total_anexos
from public.anexos_bens;
