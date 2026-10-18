# Changelog — schematize-copy

Todas as mudanças relevantes deste pacote, no formato [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/),
com versionamento [SemVer](https://semver.org/lang/pt-BR/).

## [0.1.0] — 2026-10-18
Primeira versão. Nasce de um incidente real: o usuário contou ao Claude que o plano de negócios da marca Asender era "ticket mais alto que os concorrentes, foco premium", e a copy da landing page saiu escrevendo textualmente "somos premium, mais caros que a concorrência". É o defeito clássico de LLM em copy: o texto **fala para dentro**, descreve o plano de negócios e a estratégia em vez do que o cliente precisa ler para comprar. Nenhuma skill do catálogo cobria copy de conversão (a `schematize-seo-writing` cobre artigo para ranquear), e regra de copy só em prosa vira "lembre-se de"; aqui o piso é executável.

### Adicionado
- Firewall do briefing (piso nº 1): tudo que o usuário conta do negócio é insumo, nunca texto; tradução obrigatória "o que o dono disse -> o que o cliente percebe ou ganha -> como provar na página", com tabela de exemplos e o caso Asender como primeiro.
- Pisos de leitor (o cliente, "você" acima de "nós"), estrutura de conversão (AIDA, PAS, 4U, níveis de consciência de Schwartz), especificidade e zero clichê de IA, prova nunca inventada (`[PROVA: ...]`), voz do cliente, piso legal BR (CDC, CONAR) e entrega limpa com racional separado e 3 a 5 variações.
- `scripts/check-copy.sh`: gate com exit 0/1/2 e cinco checagens (vazamento de bastidor, eco do briefing de 5+ palavras, clichê de IA, razão nós/você, prova pendente). Listas em `scripts/termos-bastidor.txt` e `scripts/cliches.txt`, extensíveis. `scripts/check-copy.test.sh` com vermelhos plantados (visto falhar antes de implementar) e verdes.
- Comandos `/copy-brief`, `/copy-lp`, `/copy-variants`, `/copy-review`, `/copy-help`, `/copy-load`, `/copy-claude`, `/copy-handoff`, `/copy-cc`.

### Não verificado
- O gate não lê paráfrase do briefing, tradução mal feita, prova inventada que parece real nem promessa ilícita; isso é leitura humana no `/copy-review`.
