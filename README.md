# TRANCILIM — Portal com login compacto

## Alterações

- primeira tela agora é o login;
- logomarca oficial da Secretaria do Trabalho;
- portal menor e mais direto;
- retirada da apresentação longa;
- após entrar, o usuário escolhe entre:
  - Gestão Patrimonial;
  - Prestação de Contas CG;
- botão para sair do portal.

## Atenção sobre o login

O login desta versão é apenas visual e provisório. Ele usa `sessionStorage` e
não oferece autenticação segura.

Não utilize senha institucional real nesta etapa.

O próximo passo é conectar o formulário ao Supabase Auth.

## Banco de dados

Os sistemas ainda não estão gravando as informações no Supabase. Eles
continuam usando armazenamento local do navegador (`localStorage` e
`IndexedDB`).
