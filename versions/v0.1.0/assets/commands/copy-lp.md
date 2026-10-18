---
description: schematize-copy — escreve a landing page completa seguindo a estrutura de conversão, a partir do /copy-brief, e roda o gate com --briefing.
argument-hint: "<produto/oferta> [briefing.md]"
---

# /copy-lp — LP completa que fala ao cliente

Alvo: `${ARGUMENTS}`. Leia antes `references/leitor-e-estrutura.md` e
`references/especificidade-prova-voz.md`.

1. **Exija o `/copy-brief` aprovado** (tabela de tradução e `briefing.txt`). Não há: rode `/copy-brief`
   primeiro. Escrever sem a tabela é a violação típica do piso nº 1.
2. **Escreva na ordem:** headline de transformação (+ sub), dor ou situação atual, solução e mecanismo,
   prova, oferta, objeções e FAQ, garantia, CTA repetido. Escolha AIDA, PAS ou 4U e o nível de
   consciência do cliente, e diga qual no racional (não na copy).
3. **Regras duras durante a escrita:** só o que a tabela de tradução autoriza; "você" acima de "nós";
   sem clichê; número, prazo e nome só se reais; prova sem fonte vira `[PROVA: ...]`; sem promessa
   de resultado nem escassez falsa (`references/legal-br.md`).
4. **Rode o gate com o briefing e corrija até exit 0:**
   `bash .claude/skills/schematize-copy/scripts/check-copy.sh lp.md --briefing briefing.md`
   (ou o caminho em `~/.claude/skills/` se a skill estiver instalada globalmente).
5. **Entregue:** tabela de tradução (resumo), a **copy limpa**, 3 a 5 variações de headline e de CTA,
   depois o **racional** em bloco separado e rotulado, as pendências (`[PROVA:]`, `[CONFIRMAR:]`,
   validação jurídica) e a saída do gate.
6. Feche dizendo o que o gate não leu: paráfrase do briefing, especificidade, prova, legal.
