Sistema de Gestão Patrimonial - SGP
Versão: v129 Leitura Paula/Docs

Base: v128.

Correções:
- A leitura do cadastro por lote foi reforçada para não depender de cache/localStorage de outro computador.
- Corrigido caso em que no computador da Paula os documentos eram lidos, mas os itens e a classificação não iam para a tabela.
- OF agora usa leitura por linhas do PDF e tenta puxar:
  código do item catálogo;
  descrição;
  quantidade;
  preço unitário;
  valor total;
  fornecedor;
  CNPJ;
  empenho citado.
- NE agora reforça número, data, valor e classificação contábil.
- Para ar condicionado/split/BTU, classifica como:
  Máquinas, aparelhos e equipamentos / Máquinas e equipamentos energéticos.
- NF continua sendo a base do valor de entrada/incorporação.
- NE global e OF com valor diferente continuam permitidas com justificativa.
- Adicionado botão: “Puxar itens e classificação dos documentos”.
- Mantidos login, layout e demais rotinas.

Rode também:
script_supabase_v129_conferencia_base.sql
