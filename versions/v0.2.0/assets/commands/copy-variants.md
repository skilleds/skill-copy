---
description: schematize-copy — 3 a 5 variações de headline, CTA ou anúncio com ângulos diferentes, validadas pelo gate.
argument-hint: "<headline|cta|anuncio> <contexto ou arquivo>"
---

# /copy-variants — variações com ângulo, não sinônimos

Alvo: `${ARGUMENTS}`. Parta do `/copy-brief` aprovado; sem ele, rode-o antes.

1. **Entregue 3 a 5 variações**, cada uma com **ângulo diferente**: benefício direto, dor, prova,
   curiosidade específica, objeção respondida. Trocar uma palavra por sinônimo não é variação.
2. Cada variação: **só o que a tabela de tradução autoriza**, voltada ao "você", específica (número ou
   situação real), sem clichê (`scripts/cliches.txt`) e sem termo de bastidor.
3. **Rode o gate** em um arquivo com todas as variações:
   `bash .claude/skills/schematize-copy/scripts/check-copy.sh variacoes.md --briefing briefing.md`.
   Variação que reprova é reescrita antes de aparecer.
4. **Formato:** as variações limpas, numeradas; **depois**, em bloco rotulado de racional, uma linha por
   variação com o ângulo e a hipótese que ela testa. Racional nunca vai dentro da variação.
5. Indique qual testaria primeiro e por quê, no racional. Diga o que não rodou (teste A/B real,
   validação jurídica de promessa).
