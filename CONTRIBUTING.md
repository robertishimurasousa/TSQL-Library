# Contribuir

Esta seleção inicial aceita consultas de leitura e exemplos sintéticos. Scripts de alteração exigem uma proposta separada de escopo e validação antes de mudar essa regra.

- Use UTF-8 sem BOM e nomes em `kebab-case.sql`, com um objetivo por arquivo.
- Informe contexto, plataforma-alvo, permissões, limitações, fonte e evidência de validação no cabeçalho. Atualize `catalog.json` e `docs/catalogo.md`.
- Use parâmetros nulos ou exemplos sintéticos. Não inclua senhas, hashes de login, tokens, arquivos compactados, dumps, resultados de consultas, nomes de clientes, endpoints ou caminhos de ambientes reais.
- Revise também comentários, nomes de arquivos e commits. Não contorne o scanner com exceções genéricas ou comentários de supressão.
- Preserve atribuições e confirme a licença da versão de qualquer código reutilizado. Prefira links oficiais para ferramentas completas de terceiros.
- Execute as verificações descritas no README. Para afirmar compatibilidade, registre execução em laboratório com versão/build, permissões usadas, cenário e resultado sem dados privados.

`tools/validate.py` usa uma política restrita de tipos de instrução e palavras operacionais. É uma barreira adicional de revisão, não um sandbox nem uma prova de que toda consulta aceita é inofensiva. Alterações nessa política precisam de casos de regressão.
