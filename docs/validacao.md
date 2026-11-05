# Validação

Data da revisão: 05/11/2026.

| Verificação | Resultado |
|---|---|
| Revisão estática dos scripts selecionados | 34 arquivos revisados |
| Parser SQLFluff 4.5.0, dialeto T-SQL | 34 arquivos, zero erros |
| Catálogo, codificação, tipos de arquivo e política de leitura | Aprovados pela checagem local |
| Testes de regressão do validador | 8 testes aprovados |
| Regras adicionais de segredos | 3 casos sintéticos detectados pelo Gitleaks |
| Gitleaks 8.30.1, regras padrão e adicionais | Zero achados nos arquivos preparados |
| Execução em SQL Server | Pendente |
| Homologação de permissões mínimas e versões | Pendente |
| Histórico Git curado | Reconstruído a partir da seleção; verificação de todas as referências mantida no CI |
| Execução do workflow no GitHub | Consultar a execução correspondente ao commit na aba Actions |

A verificação de sintaxe não resolve nomes de colunas no servidor nem testa permissões, desempenho, presença de SQL Agent/Always On ou resultados reais. O parser e o scanner não substituem revisão contextual.

## Homologação a executar em laboratório

Usar uma instância descartável, um banco de teste e dados sintéticos. Registrar versão/build e permissões, sem exportar dados privados para o Git.

- Inventário, arquivos, serviços e segurança: comparar resultados com os catálogos do laboratório; incluir uma conta de visibilidade restrita.
- Tabelas e índices: criar tabela com múltiplos índices e partições; confirmar que a contagem aproximada de linhas não é multiplicada por índices secundários.
- Bloqueios: abrir duas sessões de teste e uma transação controlada; verificar a identificação do bloqueador inclusive quando estiver sem request ativo.
- Cache e contadores: executar uma carga pequena conhecida e observar a janela dos contadores; não exigir presença de linhas após limpeza ou reinício.
- SQL Agent: incluir job nunca executado, falha, sucesso e duração superior a 24 horas; verificar segundos calculados e atividade da última sessão do Agent.
- Backup: gerar FULL, DIFF, LOG e COPY_ONLY no laboratório; confirmar a separação dos tipos. O script não valida restauração.
- Always On: exige um laboratório com AG; registrar primária, secundária e limites de visibilidade.
- Exemplos: paginação padrão deve retornar IDs 3 e 4; NULL deve marcar somente ID 1 como `Missing`; na distribuição do grupo A, os dois valores 20 têm o mesmo ranking e distribuição.

Atualizar o estado do catálogo somente com evidência da etapa concluída. Não usar o termo “validado” sem identificar se se trata de revisão estática ou execução.

## Atualização de clones anteriores

Após uma reescrita de histórico, use uma clonagem nova. Não faça merge de branches ou clones anteriores à limpeza: isso pode reintroduzir commits removidos. Guarde cópias privadas de recuperação fora do repositório e sem remoto de publicação.

O CI verifica os arquivos atuais e todo o histórico alcançável em etapas distintas. A geração de bytecode Python é desabilitada para que credenciais sintéticas dos testes não sejam incorporadas a arquivos de cache; os arquivos de origem continuam sendo inspecionados.
