-- SGP v106 - Garantia dos buckets de documentos
-- Rode no Supabase SQL Editor se algum anexo mostrar erro de bucket não encontrado.
-- Observação: criar o bucket resolve novos uploads. Se um arquivo antigo não existir no Storage,
-- será necessário reenviar o documento.

insert into storage.buckets (id, name, public)
values
  ('documentos-siafe', 'documentos-siafe', false),
  ('notas-fiscais', 'notas-fiscais', false),
  ('fotos-bens', 'fotos-bens', false),
  ('etiquetas-patrimoniais', 'etiquetas-patrimoniais', false),
  ('termos-responsabilidade', 'termos-responsabilidade', false)
on conflict (id) do nothing;
