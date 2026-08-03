-- SGP v114 - Diagnóstico seguro de duplicados e documentos faltando
-- Este script NÃO apaga nada. Ele só mostra onde há duplicidade e anexo faltando.

-- 1) Possíveis duplicados por NF + data de aquisição + descrição + valor
select
  nota_fiscal,
  data_aquisicao,
  descricao,
  valor_aquisicao,
  count(*) as quantidade,
  string_agg(numero_patrimonial, ', ' order by numero_patrimonial) as patrimoniais
from public.bens_patrimoniais
group by nota_fiscal, data_aquisicao, descricao, valor_aquisicao
having count(*) > 1
order by count(*) desc, nota_fiscal, descricao;

-- 2) Bens sem documentos obrigatórios por lote
select
  bp.numero_patrimonial,
  bp.descricao,
  bp.nota_fiscal,
  coalesce(ext.nota_empenho, '') as nota_empenho,
  case when exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'nota_fiscal') then 'OK' else 'FALTA NF PDF' end as nota_fiscal_pdf,
  case when exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'nota_empenho') then 'OK' else 'FALTA NE PDF' end as nota_empenho_pdf,
  case when exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'ordem_fornecimento') then 'OK' else 'FALTA OF PDF' end as ordem_fornecimento_pdf
from public.bens_patrimoniais bp
left join public.bens_patrimoniais_ext ext
  on ext.numero_patrimonial = bp.numero_patrimonial
where
  not exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'nota_fiscal')
  or not exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'nota_empenho')
  or not exists (select 1 from public.anexos_bens a where a.bem_id = bp.id and a.tipo_anexo = 'ordem_fornecimento')
order by bp.nota_fiscal, bp.numero_patrimonial;

-- 3) Documentos registrados na tabela, mas arquivo não encontrado no Storage
select
  bp.numero_patrimonial,
  bp.descricao,
  a.tipo_anexo,
  a.nome_arquivo,
  a.bucket,
  a.caminho_arquivo,
  case
    when exists (
      select 1 from storage.objects o
      where o.bucket_id = a.bucket
        and o.name = a.caminho_arquivo
    ) then 'OK'
    when exists (
      select 1 from storage.objects o
      where o.name = a.caminho_arquivo
    ) then 'EXISTE EM OUTRO BUCKET'
    else 'ARQUIVO NÃO ENCONTRADO - REENVIAR'
  end as status_storage
from public.anexos_bens a
left join public.bens_patrimoniais bp
  on bp.id = a.bem_id
order by bp.numero_patrimonial, a.tipo_anexo;
