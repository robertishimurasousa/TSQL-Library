# TSQL Library

Biblioteca de consultas T-SQL para diagnóstico de SQL Server e exemplos com dados sintéticos. Esta primeira seleção contém **34 scripts**, organizados por assunto, com contexto, permissões e limitações no cabeçalho.

Os arquivos passaram por revisão estática, parser T-SQL e varredura de segredos. **A execução e a compatibilidade em SQL Server ainda não foram homologadas.** SQL Server 2016+ é a plataforma-alvo desta seleção, não uma matriz de versões já testadas. Azure SQL Database, Managed Instance e Fabric exigem avaliação própria.

## Encontrar uma consulta

- [Catálogo completo](docs/catalogo.md)
- [Diagnóstico](scripts/diagnostico/): instância, bancos, arquivos, bloqueios, sessões e tempdb.
- [Performance](scripts/performance/): I/O, schedulers, cache, procedures, triggers, memória e esperas.
- [Índices e estatísticas](scripts/indices-e-estatisticas/): inventário, espaço, uso e estimativas do otimizador.
- [Backup](scripts/backup-e-restauracao/), [Always On](scripts/alta-disponibilidade/), [segurança](scripts/seguranca/) e [SQL Agent](scripts/sql-agent/).
- [Exemplos](examples/): paginação, funções de distribuição e NULL.

## Usar

1. Escolha uma consulta no catálogo e leia seu cabeçalho.
2. Abra uma conexão de laboratório e selecione o banco indicado em **Contexto**.
3. Revise permissões e parâmetros declarados. Execute o arquivo individualmente no SSMS ou cliente T-SQL equivalente.
4. Avalie o resultado considerando as limitações documentadas.

Esta seleção consulta metadados e usa somente dados sintéticos nos exemplos. Não instala jobs, procedures ou tabelas, não reconfigura a instância e não executa reparos. Consultas podem consumir recursos, obter locks de leitura e retornar nomes, caminhos ou outros dados do ambiente conectado. Não publique resultados sem revisão. Nos scripts que oferecem texto SQL, a opção vem desabilitada.

## Desenvolver e validar

Python 3.10+ e Gitleaks 8.30.1 são ferramentas de desenvolvimento; não são necessários para executar os arquivos SQL.

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements-dev.txt
python tools/validate.py
python -m unittest discover -s tests -v
gitleaks dir . --redact=100 --ignore-gitleaks-allow
gitleaks git . --log-opts="--all" --redact=100 --ignore-gitleaks-allow
```

O workflow verifica sintaxe, catálogo, tipos de arquivo, regras de leitura e segredos nos arquivos e no histórico. Ele não executa os scripts em um banco. Veja [validação](docs/validacao.md), [segurança e execução](docs/seguranca-e-execucao.md) e [como contribuir](CONTRIBUTING.md).

## Origem e licença

Seleção curada e reescrita de consultas de administração e exemplos genéricos. A documentação Microsoft está vinculada em cada script. Ferramentas completas de outros autores são indicadas em [referências](docs/referencias.md), com suas próprias licenças, sem serem incorporadas a esta seleção.

O código desta biblioteca é distribuído sob a [licença MIT](LICENSE).
