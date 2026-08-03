-- SGP v124 - Conferir fornecedor/CNPJ e pendências cadastrais
-- Não altera nada; apenas mostra bens sem fornecedor ou CNPJ na tabela extra.

select
  bp.numero_patrimonial,
  bp.descricao,
  bp.nota_fiscal,
  coalesce(ext.nota_empenho, '') as nota_empenho,
  coalesce(ext.fornecedor, '') as fornecedor,
  coalesce(ext.cnpj, '') as cnpj,
  case
    when coalesce(ext.fornecedor, '') = '' then 'SEM FORNECEDOR'
    else 'OK'
  end as status_fornecedor,
  case
    when coalesce(ext.cnpj, '') = '' then 'SEM CNPJ'
    else 'OK'
  end as status_cnpj
from public.bens_patrimoniais bp
left join public.bens_patrimoniais_ext ext
  on ext.numero_patrimonial = bp.numero_patrimonial
where coalesce(ext.fornecedor, '') = ''
   or coalesce(ext.cnpj, '') = ''
order by bp.numero_patrimonial;
