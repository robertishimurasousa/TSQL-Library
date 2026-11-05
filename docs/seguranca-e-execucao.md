# Segurança e execução

## Permissões

Use uma conta de laboratório com as permissões necessárias ao script. Não conceda `sysadmin` como solução padrão para erros de acesso. Metadados podem ser omitidos silenciosamente quando a conta não tem visibilidade suficiente.

| Família | SQL Server 2016–2019 | SQL Server 2022+ |
|---|---|---|
| Muitas DMVs de performance da instância | `VIEW SERVER STATE` | `VIEW SERVER PERFORMANCE STATE` |
| Serviços e chaves de criptografia dos bancos | `VIEW SERVER STATE` | `VIEW SERVER SECURITY STATE` |
| `sys.dm_db_partition_stats` | `VIEW DATABASE STATE` e `VIEW DEFINITION` | `VIEW DATABASE PERFORMANCE STATE` e `VIEW SECURITY DEFINITION` no banco |
| Catálogos | Visibilidade do objeto/principal | Visibilidade do objeto/principal |
| Histórico em `msdb` | Acesso às tabelas utilizadas | Acesso às tabelas utilizadas |

Esta tabela não substitui os requisitos de cada objeto. Consulte os links de referência do script e a [documentação das DMVs](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-objects/system-dynamic-management-objects). `statistics-properties.sql`, por exemplo, tem requisitos de visibilidade das estatísticas do objeto. As consultas de permissões mostram concessões explícitas; a consulta de sysadmin mostra membros diretos e não expande grupos Windows.

## Contexto e resultado

Consultas de escopo de banco usam o banco da conexão; não percorrem todos os bancos automaticamente. `tempdb-space.sql` interrompe o lote se a conexão não estiver em `tempdb`. Exemplos usam CTEs e `VALUES`, sem criar tabelas.

As consultas podem revelar identidades, caminhos, objetos, topologia e texto de comandos. O código da biblioteca não inclui dados de ambiente; os resultados de execução passam a conter dados do servidor consultado. Revise resultados antes de compartilhá-los.

DMVs de cache e contadores podem reiniciar, perder linhas ou ter visibilidade parcial. `latest-backups.sql` mostra o histórico local registrado em `msdb`; não comprova restaurabilidade nem consolida backups de todas as réplicas. `replica-status.sql` depende de Always On e da réplica consultada. `job-status.sql` mostra a última sessão registrada do Agent; não é monitor de disponibilidade do serviço.

## Segredos e histórico

O Gitleaks usa suas regras padrão e regras adicionais para senhas literais, hashes T-SQL e credenciais em `cmdkey`. A checagem contextual dos SQL também procura caminhos UNC, e-mails e IPv4 literais. Um resultado limpo não substitui revisão humana.

Se um segredo entrar no Git, identifique o proprietário, revogue ou rotacione a credencial e avalie a limpeza do histórico. Apenas apagar a linha no último commit não elimina cópias anteriores. Consulte o [procedimento do GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).
