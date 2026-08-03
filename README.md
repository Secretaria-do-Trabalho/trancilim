# TRANCILIM — Portal de acesso por módulos

## Alterações desta versão

- tela de login redesenhada no formato institucional, inspirada na organização visual do Guardião;
- inclusão da logomarca oficial do TRANCILIM;
- manutenção da marca do Governo do Ceará / Secretaria do Trabalho;
- inclusão do contato do administrador:
  - telefone: (85) 9918-7030;
  - e-mail: david.alcantara@trabalho.ce.gov.br;
- portal pós-login mostra somente os módulos autorizados para cada usuário;
- proteção provisória dos endereços dos módulos para impedir abertura direta sem autorização no portal;
- botão para sair e encerrar a sessão do portal.

## Perfis configurados para demonstração

### David Alcântara

Pode entrar usando `david`, `david.alcantara@trabalho.ce.gov.br` ou `8599187030`.
Aparecem os módulos:

- Gestão Patrimonial;
- Prestação de Contas CG.

### Paula Ivane

Pode entrar usando `paula`, `paula ivane` ou `paula.ivane`.
Aparece somente:

- Gestão Patrimonial.

Nesta versão, qualquer senha preenchida permite o teste do perfil cadastrado.

## Atenção sobre segurança

O controle de acesso desta publicação ainda é demonstrativo e usa `sessionStorage`.
Ele organiza a interface e bloqueia a navegação comum, mas não substitui autenticação e autorização seguras no servidor.

A versão definitiva deve conectar o portal ao Supabase Auth e consultar no banco os módulos permitidos para o usuário autenticado. As políticas RLS também devem proteger os dados de cada módulo.
