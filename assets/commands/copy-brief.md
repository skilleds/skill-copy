---
description: schematize-copy — recebe o briefing e produz a tabela de tradução (fato interno -> percepção do cliente -> prova) ANTES de escrever copy.
argument-hint: "<briefing ou caminho do arquivo>"
---

# /copy-brief — o briefing é insumo; a tradução vem antes da copy

Alvo: `${ARGUMENTS}` (texto do usuário ou arquivo). Leia antes `references/firewall-briefing.md`.

1. **Extraia cada fato interno** do briefing, um por linha: plano de negócios, posicionamento, preço,
   ticket, margem, público-alvo, persona, concorrentes, metas, diferenciais, "queremos parecer X".
2. **Monte a tabela**, uma linha por fato:

   | O dono disse | O cliente percebe ou ganha | Como provar na página | Entra na copy? |
   |---|---|---|---|

   Sem tradução utilizável, a coluna final diz **FORA DA COPY** (é um resultado válido; diga ao
   usuário). Nunca copie nem parafraseie a coluna 1 nas colunas 2 e 3.
3. **Liste o que falta:** público real e suas palavras (reviews, objeções), oferta (o que inclui, preço,
   condições), prova existente. Cada lacuna vira pergunta ou `[PROVA: ...]`/`[CONFIRMAR: ...]`. Nada se
   inventa.
4. **Grave o briefing bruto** num arquivo (`briefing.txt`): ele alimenta o `--briefing` do gate no
   `/copy-lp` e no `/copy-review`.
5. **Pare e peça aprovação da tabela.** Sem ela, o `/copy-lp` não começa.
6. Feche dizendo o que não rodou (o gate só roda sobre copy; aqui não há copy).
