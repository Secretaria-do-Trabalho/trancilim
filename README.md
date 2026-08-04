# TRANCELIM v176

- Prestação de Contas CG atualizada para a versão integrada v171.
- Aba Execução da Receita e Despesa corrigida para buscar saldo anterior e totais consolidados da Relação de Pagamentos.
- Rendimentos de aplicação reconhecidos em registros atuais, antigos e conciliações manuais.
- Ressarcimentos, conciliação bancária, estornos e vínculos existentes preservados.
- Encerramento Mensal atualizado para a versão 30, com reutilização completa de modelos e competência automática nos textos.
- Login, portal, Patrimônio, perfil, foto, favicon e navegação preservados.
- Nenhum dado é apagado por esta atualização.

# TRANCELIM - v164

## Atualização principal
- login integrado ao Supabase Auth;
- solicitações de cadastro gravadas na base;
- sininho para o administrador acompanhar perfis pendentes;
- aprovação de acesso aos módulos pelo portal;
- script SQL e instruções incluídos no pacote.

Ajuste exclusivo na tela de login:
- removida a linha “TRANCELIM — Sistema Integrado de Controle e Gestão” abaixo da logo;
- mantidos a logo, o fundo, o card de login, as posições, as cores e os demais textos;
- funcionamento do login preservado;
- nenhum módulo interno foi alterado;
- permanece sem botão de visualizar senha.

Suba todos os arquivos mantendo as pastas `assets`, `patrimonio` e `prestacao-contas`.
Depois abra com Ctrl+F5.


## v140
- Corrigido cadastro provisório de Paula Carvalho.
- Login liberado para paula.carvalho@trabalho.ce.gov.br.
- Acesso mantido somente ao Sistema de Gestão Patrimonial, com permissão total.

## v144
- Corrigida a foto de perfil: a foto padrão de David não é mais exibida para outros usuários.
- Usuários sem foto passam a ver somente suas iniciais.


## v145
- Integrada a versão mais recente enviada do Sistema de Gestão Patrimonial (v127 do módulo).
- Mantidos o login central do TRANCELIM, as permissões do portal e o acesso sem novo login.
- Mantida a regra de foto individual: David usa sua foto; usuários sem foto veem somente as iniciais.
- Sistema de Prestação de Contas CG e portal mantidos sem alteração funcional.

## v154
- Integrada a versão v39 do Sistema de Prestação de Contas CG.
- Permitido cadastrar a mesma conta bancária com tipos diferentes, mantendo bloqueio apenas para duplicidade completa de banco, agência, conta e tipo.
- Removido o selo “MODO LEVE” do módulo.
- Mantidos o login central, as permissões do portal, o perfil do usuário e o retorno à tela inicial do TRANCELIM.
- Sistema de Gestão Patrimonial v127 e demais arquivos do portal preservados.

- Sistema de Prestação de Contas CG atualizado para v40 (datas da prestação).

- v154: Sistema de Prestação de Contas CG atualizado para v43 (filtros de acompanhamento), mantendo integração do portal TRANCELIM.


## v156
- Sistema de Prestação de Contas CG atualizado para a versão v45.
- Adicionada leitura dos relatórios do Conselho de Administração 2024 e do Conselho Fiscal.
- Mantidas as correções do dashboard, a integração de login, perfil, foto e retorno ao portal.
- Atualizado o Sistema de Prestação de Contas CG para a v46, com a função Copiar responsável.

- Acompanhamento da Prestação de Contas independente dos filtros gerais do dashboard; usa somente os filtros internos da própria aba.


## v164
- limpeza automática única dos dados das abas Pagamentos e Extratos;
- preservados contratos, responsáveis, pessoal, prestações de contas e demais módulos.


## v164
- corrigida a importação do Relatório Mensal de Pagamentos em PDF, mantendo número do processo, PESSOAL e CUSTEIO;
- o extrato bancário deixou de criar pagamentos artificiais;
- corrigida a leitura de documentos bancários longos colados ao valor;
- em linhas bancárias com valor do lançamento e saldo, a conciliação usa o valor do lançamento;
- conciliação automática por documento, data e valor, inclusive quando um débito bancário reúne várias linhas do relatório;
- Pix rejeitado/estornado é identificado e não aumenta o valor pago;
- extrato CDB é guardado como documento de aplicação e não entra na conciliação operacional;
- incluídos totais separados de PESSOAL e CUSTEIO;
- limpeza única dos dados incorretos de Pagamentos e Extratos para nova importação.


## v165 — Sistema de Encerramento Mensal

- Adicionado o módulo `/encerramento-mensal/`, baseado na versão v25.
- Novo card no portal principal.
- Login único e retorno ao portal pelo cabeçalho.
- Administradores recebem acesso automático ao novo módulo.
- Solicitação de cadastro permite pedir acesso ao Encerramento Mensal ou a todos os sistemas.


## v167
- Prestação de Contas CG atualizada para a versão v166 enviada.
- Eliminado o piscar da tela de login ao entrar nos módulos e voltar ao portal.
- Favicon da bandeira TRANCELIM unificado no portal e em todos os módulos.

## v169
- Sistema de Encerramento Mensal atualizado para a versão v26 enviada.
- Aplicada a nova regra do Anexo II para os fundos FET, FIMPC e FERDT.
- Mantidos o login único, o perfil do usuário, o retorno ao portal e o favicon da bandeira TRANCELIM.
- Mantidas a barra lateral fixa, a remoção da versão visível no menu e os ajustes anteriores do módulo.
- Prestação de Contas CG v166 e Gestão Patrimonial preservadas sem alterações.


## v169 - correção da importação de extratos
- Corrigido erro `key is not defined` no acompanhamento Conta Corrente ↔ Aplicação.
- A importação de extratos agora possui rollback: se ocorrer erro, os vínculos e conciliações anteriores são restaurados.
- Reparo automático único reprocessa conciliações existentes sem apagar vínculos manuais.


## v170
- Sistema de Encerramento Mensal atualizado para a versão v28 enviada.
- O despacho passou a integrar o cadastro do próprio processo.
- A aba separada de Despachos foi removida conforme a nova versão.
- Mantidos login único, perfil, foto, retorno ao portal, favicon e barra lateral fixa.
- Prestação de Contas CG com a correção de extratos da v169 e Gestão Patrimonial preservadas.


## v172
- Prestação de Contas CG atualizada com a correção do Demonstrativo de Execução da Receita e Despesa da v167.
- Preservadas as correções de conciliação bancária da v168.
- O botão Atualizar conciliação não apaga vínculos válidos e reprocessa somente pendências.
- Nenhum dado de pagamentos, extratos ou conciliações é apagado.
- Encerramento Mensal v28, Patrimônio e portal preservados.

## v173
- Na edição de pagamento, o campo Crédito da devolução mostra somente créditos do mesmo contrato previamente classificados como **Ressarcimento recebido**.
- Créditos já vinculados a outro pagamento não aparecem novamente na lista.
- Ao salvar o pagamento, o crédito selecionado passa a constar no extrato como **RESSARCIMENTO VINCULADO**, com identificação do pagamento.
- Ao remover o vínculo ou mudar a classificação do crédito, o extrato e o pagamento são atualizados de forma consistente.


## v176
- Encerramento Mensal v31 integrado.
- Referência selecionada permanece após F5; padrão inicial julho/2026.
- Percentual por UG ponderado por documento, incluindo Anexos I, II e III.
- Links internos sem index.html visível.


## v176
- Encerramento Mensal: SEM, navegação padronizada e despacho Montserrat Normal 11.
- Botão Copiar despacho corrigido com cópia rica e fallback.
- Cabeçalho institucional abre o dashboard interno; marca do sistema retorna ao portal.
