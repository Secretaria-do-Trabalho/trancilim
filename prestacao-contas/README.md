# Sistema de Prestação de Contas CG — v165

## Pagamentos e extratos zerados

Ao abrir a v165 pela primeira vez, o sistema apaga somente:

- pagamentos cadastrados e importados;
- relatórios mensais de pagamentos;
- comprovantes vinculados aos pagamentos;
- extratos bancários;
- lançamentos bancários;
- vínculos da conciliação;
- transferências entre conta corrente e aplicação geradas pelos extratos;
- pendências do módulo de pagamentos.

Permanecem preservados contratos, contas bancárias cadastradas, responsáveis, pessoal, cronogramas e os demais módulos.

## Selecionar débito pelo pagamento

Na Relação de Pagamentos, cada pagamento possui a ação **Selecionar débito**. A janela mostra somente débitos:

- do mesmo contrato;
- da mesma competência;
- ainda não conciliados ou parcialmente conciliados;
- com saldo disponível.

Também foi incluído no cadastro manual de pagamento o campo **Débito do extrato bancário**. Ao selecionar um débito, o sistema pode preencher documento, data de compensação e valor, e cria o vínculo ao salvar.

Um pagamento pode continuar ligado a mais de um débito, e um débito pode ser distribuído entre vários pagamentos, respeitando os saldos disponíveis.
