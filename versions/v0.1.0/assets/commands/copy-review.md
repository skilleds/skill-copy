---
description: schematize-copy — revisa copy existente: gate + leitura do que a máquina não lê (firewall, especificidade, prova, legal) e entrega reescrita.
argument-hint: "<copy.md> [--briefing <briefing.md>]"
---

# /copy-review — gate primeiro, depois o que a máquina não lê

Alvo: `${ARGUMENTS}`. Leia antes `references/firewall-briefing.md` e `references/entrega-e-gate.md`.

1. **Rode a máquina:**
   `bash .claude/skills/schematize-copy/scripts/check-copy.sh <copy> [--briefing <briefing>]`.
   Reporte o exit e cada achado com a linha. Exit `2` = nada foi verificado e **não é aprovação**.
2. **Leia o que a máquina não lê**, frase a frase:
   - **Firewall:** a frase veio do briefing, mesmo parafraseada? O cliente ganha algo ao lê-la?
   - **Leitor:** "nós/somos" onde caberia "você"? Característica sem benefício?
   - **Especificidade:** adjetivo sem número, prazo ou nome? Promessa sem objeto?
   - **Prova:** depoimento, número, logo ou selo sem fonte? Vira `[PROVA: ...]`.
   - **Legal:** promessa de resultado, escassez falsa, preço ou condição escondida, comparação sem base
     (`references/legal-br.md`).
   - **Estrutura:** falta bloco (dor, prova, objeção, garantia)? CTA único e fraco?
3. **Entregue a reescrita limpa** (sem racional dentro) e, em bloco separado e rotulado, a lista de
   achados: o que mudou e por quê, o que ficou pendente do usuário (`[PROVA:]`, `[CONFIRMAR:]`).
4. **Rode o gate de novo** na reescrita até exit 0.
5. Feche dizendo o que não rodou (validação jurídica, teste com público real).
