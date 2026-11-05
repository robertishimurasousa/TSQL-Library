# Catálogo

34 scripts de leitura e exemplos sintéticos. Plataforma-alvo: SQL Server 2016+. A compatibilidade de execução ainda precisa de homologação.

Escolha o banco indicado antes de executar. Cada arquivo informa permissões e limitações. Os links Microsoft no cabeçalho documentam os objetos consultados.

| Script | Finalidade | Contexto |
|---|---|---|
| [instance-info](../scripts/diagnostico/instance-info.sql) | Informações da instância | qualquer banco |
| [database-inventory](../scripts/diagnostico/database-inventory.sql) | Inventário dos bancos | qualquer banco |
| [database-files](../scripts/diagnostico/database-files.sql) | Arquivos e crescimento dos bancos | qualquer banco |
| [service-status](../scripts/diagnostico/service-status.sql) | Estado dos serviços | qualquer banco |
| [blocked-sessions](../scripts/diagnostico/blocked-sessions.sql) | Sessões bloqueadas e bloqueadores | qualquer banco |
| [active-requests](../scripts/diagnostico/active-requests.sql) | Requests em execução | qualquer banco |
| [session-resources](../scripts/diagnostico/session-resources.sql) | Recursos por sessão | qualquer banco |
| [session-locks](../scripts/diagnostico/session-locks.sql) | Locks no banco selecionado | banco a inspecionar |
| [suspect-pages](../scripts/diagnostico/suspect-pages.sql) | Páginas suspeitas registradas | qualquer banco |
| [tempdb-space](../scripts/diagnostico/tempdb-space.sql) | Uso dos arquivos de dados de tempdb | tempdb |
| [file-io](../scripts/performance/file-io.sql) | I/O acumulado por arquivo | qualquer banco |
| [scheduler-pressure](../scripts/performance/scheduler-pressure.sql) | Filas dos schedulers | qualquer banco |
| [procedure-statistics](../scripts/performance/procedure-statistics.sql) | Estatísticas de procedures em cache | banco a inspecionar |
| [trigger-statistics](../scripts/performance/trigger-statistics.sql) | Estatísticas de triggers em cache | banco a inspecionar |
| [top-query-cpu](../scripts/performance/top-query-cpu.sql) | Consultas em cache por cpu | qualquer banco |
| [top-query-logical-reads](../scripts/performance/top-query-logical-reads.sql) | Consultas em cache por logical-reads | qualquer banco |
| [memory-configuration](../scripts/performance/memory-configuration.sql) | Configuração e estado da memória | qualquer banco |
| [wait-statistics](../scripts/performance/wait-statistics.sql) | Esperas acumuladas da instância | qualquer banco |
| [table-space](../scripts/indices-e-estatisticas/table-space.sql) | Espaço de tabelas em disco | banco a inspecionar |
| [index-inventory](../scripts/indices-e-estatisticas/index-inventory.sql) | Inventário de índices e data spaces | banco a inspecionar |
| [index-usage](../scripts/indices-e-estatisticas/index-usage.sql) | Contadores de uso de índices | banco a inspecionar |
| [missing-index-estimates](../scripts/indices-e-estatisticas/missing-index-estimates.sql) | Estimativas de índices ausentes | banco a inspecionar |
| [statistics-properties](../scripts/indices-e-estatisticas/statistics-properties.sql) | Propriedades das estatísticas | banco a inspecionar |
| [latest-backups](../scripts/backup-e-restauracao/latest-backups.sql) | Últimos backups de cada tipo | qualquer banco |
| [replica-status](../scripts/alta-disponibilidade/replica-status.sql) | Estado das réplicas de bancos | instância com Always On habilitado |
| [sysadmin-members](../scripts/seguranca/sysadmin-members.sql) | Membros diretos de sysadmin | qualquer banco |
| [database-permissions](../scripts/seguranca/database-permissions.sql) | Permissões explícitas no banco | banco a inspecionar |
| [orphan-sql-users](../scripts/seguranca/orphan-sql-users.sql) | Candidatos a usuários SQL órfãos | banco de usuário |
| [encryption-status](../scripts/seguranca/encryption-status.sql) | Estado de criptografia dos bancos | qualquer banco |
| [job-status](../scripts/sql-agent/job-status.sql) | Estado e última conclusão dos jobs | instância com SQL Server Agent |
| [job-history](../scripts/sql-agent/job-history.sql) | Histórico de conclusões dos jobs | instância com SQL Server Agent |
| [pagination](../examples/pagination.sql) | Paginação com ordenação determinística | qualquer banco |
| [distribution-functions](../examples/distribution-functions.sql) | Distribuição e posição percentual | qualquer banco |
| [null-predicates](../examples/null-predicates.sql) | Predicados para valores NULL | qualquer banco |

## Estado da revisão

Todos os arquivos receberam revisão estática e passaram pelo parser T-SQL do SQLFluff. Nenhum está marcado como testado em SQL Server. `catalog.json` fornece o mesmo inventário em formato estruturado.

Consultas de DMVs mostram um instante ou contadores acumulados, com visibilidade dependente de permissões. Não interpretar um resultado vazio como prova de saúde, ausência de acesso ou inexistência de uso.
