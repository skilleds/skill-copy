# schematize-copy

> **Copy que vende ao cliente, não descreve o negócio.** O briefing do dono é insumo, nunca texto:
> cada fato interno é traduzido no que o cliente percebe e em como provar na página. Um gate
> executável barra o vazamento antes da entrega.

Pacote de **skill normativa para [Claude Code](https://claude.com/claude-code)**.
Parte do catálogo **schematize skills**.

## Por que ela existe

O usuário contou que a marca tinha "ticket mais alto que os concorrentes, foco premium" e a landing
page saiu com "somos premium, mais caros que a concorrência". Copy que fala para dentro é o defeito
clássico de LLM. Aqui o firewall do briefing, os clichês banidos, a razão nós/você e o eco do briefing
viram `scripts/check-copy.sh`, com casos vermelhos plantados em `scripts/check-copy.test.sh`.

## Instalar

### Pelo app schematize (recomendado)

```bash
schematize install copy    # requer o CLI schematize instalado
```

### Manual

```bash
git clone https://github.com/schematizeme/skill-copy.git /tmp/skill-copy
bash /tmp/skill-copy/install.sh .        # instala em .claude/ do projeto atual
bash /tmp/skill-copy/install.sh "$HOME"  # ou globalmente
```

## Comandos

`/copy-brief` (tradução do briefing) · `/copy-lp` (landing completa) · `/copy-variants` (3 a 5
variações) · `/copy-review` (revisão) · `/copy-help` · `/copy-load` · `/copy-claude` · `/copy-cc` ·
`/copy-handoff`.

## Fronteira

Artigo para ranquear: `schematize-seo-writing`. Visual e layout: `schematize-design`. Páginas legais e
institucionais: `schematize-institutional`. Implementação do front: `schematize-web`.

## Requisitos

`bash`, `grep`, `sed` e `awk` (gate e teste). Sem dependências de pacote.
