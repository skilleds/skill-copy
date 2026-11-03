# Copy de conversão (schematize-copy) — sempre-on

Copy vende ao **cliente**; não descreve o negócio. Visual é da `schematize-design`, artigo para
ranquear da `schematize-seo-writing`, páginas legais da `schematize-institutional`.

1. **Firewall do briefing:** o que o usuário conta do negócio (plano, posicionamento, preço, ticket,
   margem, público-alvo, persona, concorrentes, metas, jargão) é **insumo, nunca texto**. Proibido
   parafrasear ou citar. Antes de escrever, traduza: "o que o dono disse -> o que o cliente percebe
   ou ganha -> como provar na página". "Ticket mais alto, foco premium" nunca vira "somos premium";
   vira resultado, cuidado, acabamento, garantia, prova e valor ancorado antes do preço.
2. **O leitor é o cliente:** toda frase passa em "o cliente ganha algo ao ler isto?". "Você" acima de
   "nós/somos". Benefício antes de característica.
3. **Estrutura:** headline de transformação, dor, solução/mecanismo, prova, oferta, objeções/FAQ,
   garantia, CTA repetido (AIDA, PAS, 4U como apoio).
4. **Sem clichê de IA** ("revolucionário", "solução completa", "eleve", "potencialize", "de ponta",
   "jornada", "não é apenas X, é Y", trinca de adjetivos). Número, prazo e nome só se reais.
5. **Prova nunca inventada:** sem fonte do usuário, `[PROVA: o que entra aqui]`. Nunca fabricar
   depoimento, número, logo, selo ou avaliação.
6. **Legal BR:** CDC e CONAR; sem promessa de resultado garantido, sem escassez falsa, preço e
   condições claros.
7. **Entrega:** copy limpa, racional em bloco separado depois, 3 a 5 variações de headline e CTA.
   Gate antes: `bash .claude/skills/schematize-copy/scripts/check-copy.sh copy.md --briefing
   briefing.md` em exit 0 (exit 2 não é aprovação).
8. **Mídia:** imagem nunca por modelo Claude; pergunte Codex/Gemini ao usuário (nenhum disponível:
   avise que sai ruim e ofereça banco com licença ou asset do cliente).
9. <!-- herdado:engineering/orquestracao:curto -->**Orquestrador não desenvolve; subagent barato executa.** O agent principal só planeja, despacha e revisa; ação onerosa vira micro-tasks para o executor mais barato que resolve: `haiku` (mecânico) / `sonnet` (código; falhou → mesmo subagent corrige, até 2 rodadas) → Codex `gpt-5.6-terra` → Cursor → subagent `opus` (motivo) → `park`; **visual vai direto ao Codex**; **imagem nunca pelo Claude: detectar Codex/Gemini e perguntar ao usuário qual usar (Codex é a sugestão), nunca API de imagem paga**; papéis em `agentes.toml`. No overdev, cada item do checklist vai a um subagent e o principal revisa antes do `- [x]`. **Sem frota ociosa:** idle com pendência volta ao trabalho; dependente de outro agent → mata e enfileira com gatilho; terminou → mata (§9.6). Detalhe: `schematize-engineering` → `references/orquestracao.md` §9.<!-- /herdado -->

<!-- herdado:engineering/pisos-22-29:bloco -->**Herda os pisos 22–29 da `schematize-engineering`** (texto completo em `assets/CLAUDE.md` dela): 22 tudo no git — sem remote, push falho ou HEAD≠origin a demanda NÃO se conclui; 23 deploy só do git (VETADO scp/rsync/tar|ssh/docker save|load/git bundle); 24 o ops é o gate da IA — a IA nunca muda a VPS direto nem escreve SQL, só operação nomeada (`ssh vps "ops <op>"`); 25 sem agents inúteis (entregou, morreu); 26 relatório a cada 30 min e handoff a cada 6 h; 27 CI remoto só antes do hml, a pedido ou em tag (`workflow_dispatch` + `hml-*`/`v*`; VETADO `pull_request`, `push` em branch, `workflow_run`, cron sem justificativa); 28 microserviço autônomo (fila durável + 7 testes de resiliência); 29 build/teste na máquina dev/hml quando existe (ponte só no workspace de build, nunca prd) + higiene (`scripts/higiene.sh`).<!-- /herdado -->
