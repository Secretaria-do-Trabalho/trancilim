# Sistema de Prestação de Contas CG — v161

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
