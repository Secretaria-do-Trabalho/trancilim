# Sistema de Prestação de Contas CG — v169

Integração da correção do Demonstrativo de Execução da Receita e Despesa da v167 com a conciliação bancária restaurada da v168.

## Demonstrativo de Execução da Receita e Despesa

- A coluna **Sistema** passou a usar as fontes corretas de cada item:
  - parcela recebida: créditos classificados como repasse da SET;
  - recursos de outros contratos: créditos classificados ou transferências recebidas de outro contrato;
  - saldo do período anterior: valor lido da Relação de Pagamentos, com recuperação automática do PDF já armazenado e fallback para os extratos;
  - receita de rendimentos: rendimentos identificados no extrato de aplicação;
  - outros recebimentos e ressarcimentos: demais créditos do extrato, sem considerar estornos vinculados como nova receita;
  - despesas: valores pagos da Relação de Pagamentos da conta selecionada.
- Foi incluída a seleção entre **Conta principal de gestão** e **Conta de provisão** dentro do demonstrativo.
- As despesas do valor recebido passaram a exibir o detalhamento interno em **Pessoal**, **Custeio** e **Despesas da OS**.
- O saldo do contrato passou a ser calculado depois de todas as receitas, despesas, transferências e rendimentos da competência.
- O sistema compara o saldo calculado com o saldo final disponível nos extratos e mostra eventual diferença.
- A leitura do PDF do Demonstrativo da OS foi corrigida para preencher cada linha pelo respectivo rótulo, inclusive valores zerados e os saldos do contrato e de rendimentos.
- A importação da Relação de Pagamentos passou a identificar e guardar o **Saldo do período anterior**, permitindo também a correção manual desse valor na prévia.

---

## Histórico da v166

## Conciliação editável entre Conta Corrente e Aplicação

- Cada linha do acompanhamento possui a ação **Editar / Conciliar**.
- O usuário pode corrigir data, movimento e valor dos lançamentos identificados.
- É possível selecionar um lançamento da conta corrente e vários lançamentos da aplicação, ou o inverso.
- A conciliação manual somente é confirmada quando os totais dos dois lados coincidem, com tolerância de dois centavos.
- O vínculo manual permanece preservado ao executar novamente a conciliação automática.
- A conciliação manual pode ser desfeita, devolvendo os lançamentos à análise automática.
- Quando a composição envolve contas físicas diferentes, a listagem mostra as contas utilizadas no vínculo.

## Conta principal de gestão e conta de provisão

- Os relatórios e arquivos já existentes são tratados como pertencentes à **Conta principal de gestão**.
- A importação do Relatório Mensal de Pagamentos da OS passou a oferecer as opções **Conta principal de gestão** e **Conta de provisão**.
- A classificação é guardada no relatório, nos pagamentos importados e no documento anexado.
- Relatórios idênticos de gestão e provisão permanecem separados, sem sobrescrever ou mesclar os registros entre as duas contas.

---


## Vinculação manual de estornos na aba Extratos

- Débitos podem ser vinculados manualmente aos créditos de estorno ou PIX rejeitado sem sair da aba de Extratos.
- Créditos de estorno também exibem a ação **Vincular débito**.
- A seleção considera lançamentos de mesmo valor, conta e competência.
- Vínculos automáticos incorretos podem ser substituídos por um vínculo manual.
- O vínculo manual permanece preservado quando a conciliação automática é executada novamente.
- O sistema impede classificar como estornado um débito que ainda esteja vinculado à Relação de Pagamentos.
- A coluna de vínculo mostra o débito original ou o crédito de estorno relacionado.

---

## Rol de Responsáveis

### Barra de rolagem superior

A tabela de responsáveis possui agora uma barra de rolagem horizontal acima do
cabeçalho. A barra superior e a barra inferior permanecem sincronizadas.

### Copiar responsável

Foi acrescentada a ação **Copiar**.

Ao copiar:

- o cadastro original não é alterado;
- os dados pessoais são preenchidos automaticamente;
- categoria, representação, endereços e observações são mantidos;
- períodos de gestão são copiados;
- atos são copiados;
- publicações anexadas aos atos são duplicadas e vinculadas ao novo contrato;
- o campo Contrato fica vazio para selecionar o novo vínculo.

Depois, basta selecionar o outro Contrato de Gestão, fazer os ajustes
necessários e clicar em **Salvar responsável**.


## Importação e conciliação v161

- Relação de Pagamentos é a fonte oficial dos pagamentos.
- Extrato de conta corrente não cria pagamentos automaticamente.
- A conciliação usa documento, data de compensação e valor.
- Um débito pode ser conciliado com várias linhas que tenham o mesmo documento e totalizem seu valor.
- Débitos estornados por Pix rejeitado são separados dos débitos efetivos.
- Extratos de aplicação/CDB ficam anexados, sem integrar a conciliação de despesas.

## Conciliação bancária preservada nesta integração

- O botão **Atualizar conciliação** preserva vínculos automáticos e manuais válidos.
- Somente lançamentos pendentes são reprocessados.
- A conciliação usa contrato, documento, valor e datas, aceitando diferença de até três dias.
- Pagamentos agrupados, tributos pagos juntos, pagamentos divididos em vários débitos e estornos permanecem suportados.
- A importação de extratos mantém rollback: em caso de erro, extratos e vínculos anteriores são restaurados.
- Não existe rotina de limpeza de pagamentos, extratos ou conciliações nesta versão.
