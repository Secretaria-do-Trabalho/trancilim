# Sistema de Prestação de Contas CG — v45

## Novos relatórios reconhecidos

O importador do **Rol de Responsáveis pela Organização Social** agora reconhece:

### Conselho de Administração - 2024

O sistema lê o relatório cadastral e identifica:

- nome;
- CPF;
- e-mail funcional;
- e-mail pessoal, quando informado;
- telefone;
- endereço funcional;
- endereço residencial;
- data de nascimento;
- instituição ou condição representada;
- data do Termo de Posse;
- período do mandato.

A data do Termo de Posse é criada como ato do tipo **Termo de Posse**.
Página, publicação e documento do ato continuam pendentes quando não constarem
no relatório.

### Cadastro dos Membros - Conselho Fiscal

O sistema lê as tabelas por instituição e identifica os conselheiros titulares
e suplentes, preenchendo:

- nome;
- CPF;
- nascimento;
- endereço comercial;
- setor/cargo;
- telefone ou celular;
- e-mail comercial;
- endereço residencial;
- e-mail particular;
- instituição representada;
- condição de titular ou suplente.

Os registros escritos como **SEM INDICAÇÃO** não são criados.

Como o relatório do Conselho Fiscal não apresenta mandato nem ato de
designação/publicação, esses itens permanecem como pendência para preenchimento
na prévia editável.
