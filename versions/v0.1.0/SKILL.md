---
name: schematize-copy
metadata:
  version: 0.1.0
description: >-
  Copy de conversão para LP, anúncio, e-mail de venda e CTA, sem vazar o briefing. Use ao escrever ou revisar copy de LP, anúncio, e-mail ou CTA. Artigo SEO: schematize-seo-writing.
---

# Copy de conversão da casa (schematize-copy)

Copy de resposta direta para **vender**: landing page, hero, anúncio, e-mail de venda, página de preço
e CTA. A tese: o defeito clássico de LLM é a copy que **fala para dentro**, que descreve o plano de
negócios em vez do que o cliente precisa ler para comprar. Incidente real: o usuário contou que a
marca Asender tinha "ticket mais alto que os concorrentes, foco premium" e a landing page saiu com
"somos premium, mais caros que a concorrência". Aqui o briefing é **insumo, nunca texto**, e a máquina
confere isso antes da entrega.

**Versão:** skill `schematize-copy` v0.1.0. Changelog em `CHANGELOG.md`.

## Precedência e herança (leia antes de divergir)

<!-- herdado:engineering/precedencia:dominio intro="Esta skill é **ferramenta de conteúdo**, não de linguagem: cuida da **copy de conversão** (landing page, anúncio, e-mail de venda, oferta e CTA). Artigo para ranquear é da `schematize-seo-writing`; visual e layout, da `schematize-design`; páginas legais e institucionais, da `schematize-institutional`; implementação do front, da `schematize-web`. Esta skill só escreve o texto que vende." cmd="copy" -->Esta skill é **ferramenta de conteúdo**, não de linguagem: cuida da **copy de conversão** (landing page, anúncio, e-mail de venda, oferta e CTA). Artigo para ranquear é da `schematize-seo-writing`; visual e layout, da `schematize-design`; páginas legais e institucionais, da `schematize-institutional`; implementação do front, da `schematize-web`. Esta skill só escreve o texto que vende.

1. **Onde esta skill divergir da base, a BASE MANDA.** Aqui mora a especialização do domínio ou da
   ferramenta — o como, o padrão, o gate. Divergência de *piso* é defeito desta skill, não variante local.
2. **O que não está repetido aqui é HERDADO, não dispensado.** Esta skill herda os pisos da base e
   os comandos dela cobrem o **domínio**, não o piso geral. Valem integralmente, sem cópia local:
   - **§28 Archive** — `<projeto>/<projeto>_archive/` é **repositório git próprio, PRIVADO e
     obrigatório**, criticidade 0 (`schematize-archive`).
   - **§35 Definition of Done** e a lista de anti-padrões (citada por **título**, nunca por número).
   - **§39 Índice/MAPA** — enumeração exaustiva (uma entrada por unidade chamável, `M == N`) e grafo
     com arestas em ASCII (`A -> B`), nunca a seta unicode.
   - **IAM** (`schematize-engineering` → `references/iam.md`): identidade ≠ email, ≥2 fatores, ReBAC
     multi-tenant, argon2id-only para senha nova, sessão longa e logout irreversível.
   - **Efeito externo** nunca sai de não-produção (`schematize-engineering` →
     `references/efeitos-externos.md`).
   - **Orquestração** (`schematize-engineering` → `references/orquestracao.md` §9): o principal não
     desenvolve (é Claude Opus); executor mais barato que resolve — `haiku`/`sonnet` → Codex Terra → Cursor → `opus` só após falha; visual direto ao Codex; imagem nunca pelo Claude: detecta Codex/Gemini e pergunta ao usuário qual usar (Codex é a sugestão, não automática), nunca API paga.
3. **QA, ops, IAM e índice não têm comando próprio aqui:** vêm da base `/eng-*`. Para trabalho
   contínuo use `/eng-overdev`; para planejar `/eng-plan`; para varrer a base `/eng-scan`; para
   revisão geral `/eng-review` (e `/eng-ops`, `/eng-iam`, `/eng-index`). Os comandos
   `/copy-*` cobrem o domínio desta skill; o piso geral é o da base.<!-- /herdado -->

## Fronteira com as outras skills

| Assunto | Dono | Ponteiro |
|---|---|---|
| **Copy de conversão: LP, hero, anúncio, e-mail de venda, página de preço, CTA, microcopy** | **esta skill** | `references/*.md` abaixo |
| Artigo ou conteúdo para ranquear (outline, briefing por seção, keywords) | `schematize-seo-writing` | `schematize-seo-writing -> SKILL.md` |
| Visual, layout, hierarquia da página | `schematize-design` | `schematize-design -> SKILL.md` |
| Páginas legais e institucionais (termos, privacidade, sobre) | `schematize-institutional` | `schematize-institutional -> SKILL.md` |
| Implementar a página (componentes, rotas, i18n, a11y) | `schematize-web` | `schematize-web -> SKILL.md` |

## Comandos (Claude Code)

| Comando | O que faz |
|---|---|
| `/copy-brief` | recebe o briefing e entrega a tabela de tradução (fato interno -> percepção do cliente -> prova) **antes** de qualquer copy |
| `/copy-lp` | escreve a LP completa a partir do `/copy-brief` e roda o gate com `--briefing` |
| `/copy-variants` | 3 a 5 variações de headline, CTA ou anúncio, com ângulos diferentes |
| `/copy-review` | revisa copy existente: gate + leitura do que a máquina não lê; entrega reescrita |
| `/copy-help` | lista os comandos |
| `/copy-load` | carrega à força o corpo normativo |
| `/copy-claude` | cria/mescla o `CLAUDE.md` sempre-on de copy na raiz do repo |
| `/copy-cc` · `/copy-handoff` | context compact / handoff arquivado |

## Como usar

1. **Briefing primeiro:** `/copy-brief`. Sem a tabela de tradução aprovada, não se escreve copy.
   Falta público, oferta ou prova real: pergunte ou marque `[CONFIRMAR: ...]`/`[PROVA: ...]`.
2. **Escreva** seguindo a estrutura de `references/leitor-e-estrutura.md`, com as palavras do cliente
   (`references/especificidade-prova-voz.md`).
3. **Rode o gate com o briefing:** `bash scripts/check-copy.sh copy.md --briefing briefing.md`
   e corrija até exit 0 (`references/entrega-e-gate.md`). Exit `2` não é aprovação.
4. **Entregue limpo:** a copy sem racional embutido, e o racional num bloco separado e rotulado.

Mapa de references:

| Tarefa | Reference |
|---|---|
| Firewall do briefing, tabela de tradução, caso Asender, o que o gate pega e não pega | `references/firewall-briefing.md` |
| O leitor é o cliente, estrutura de conversão, AIDA, PAS, 4U, níveis de consciência, tipos de peça | `references/leitor-e-estrutura.md` |
| Especificidade, clichês banidos, prova nunca inventada (`[PROVA:]`), voz do cliente | `references/especificidade-prova-voz.md` |
| Piso legal BR: CDC, CONAR, promessa, escassez falsa, preço claro | `references/legal-br.md` |
| Formato da entrega, regras do gate, o que o gate não cobre, como estender as listas | `references/entrega-e-gate.md` |

Scripts: `scripts/check-copy.sh` (gate) com `scripts/check-copy.test.sh` (vermelhos e verdes
plantados); listas de dados em `scripts/termos-bastidor.txt` e `scripts/cliches.txt`.

## Pisos inegociáveis (vetam o atalho)

1. **Firewall do briefing:** plano de negócios, posicionamento, preço, ticket, margem, público-alvo,
   persona, concorrentes, metas e jargão interno são **insumo, nunca texto**. Proibido parafrasear ou
   citar o briefing. Todo fato interno passa por "o que o dono disse -> o que o cliente percebe ou
   ganha -> como provar na página". "Ticket mais alto, foco premium" **nunca** vira "somos premium"
   nem "mais caros que a concorrência": vira resultado, cuidado, acabamento, garantia, prova e
   ancoragem de valor antes do preço (`references/firewall-briefing.md`).
2. **O leitor é o cliente:** cada frase passa em "o cliente-alvo ganha algo ao ler isto?"; senão, corta.
   Foco em "você", não em "nós/somos". Benefício e transformação antes de característica.
3. **Estrutura de conversão:** headline de transformação, dor ou situação, solução e mecanismo, prova,
   oferta, objeções e FAQ, garantia, CTA claro e repetido. AIDA, PAS e 4U como apoio; escolha pelo
   nível de consciência do cliente.
4. **Especificidade vence adjetivo; zero clichê de IA:** nada de "revolucionário", "solução
   completa", "no mundo de hoje", "eleve", "desbloqueie", "potencialize", "de ponta", "inovador",
   "jornada", "não é apenas X, é Y", trinca de adjetivos. Números, prazos e nomes, só se reais.
5. **Prova nunca inventada:** depoimento, número, cliente, logo, selo, avaliação só com fonte real do
   usuário; senão, o marcador visível `[PROVA: descrever o que entra aqui]`.
6. **Voz do cliente:** as palavras que ele usa (reviews, conversas, objeções reais) e o registro do
   público.
7. **Piso legal BR:** CDC (a oferta vincula; publicidade enganosa ou abusiva) e CONAR; sem promessa de
   resultado que não se garante; sem escassez falsa; preço e condições claros
   (`references/legal-br.md`).
8. **Entrega limpa e gate verde:** a copy final sem racional embutido; o racional num bloco separado e
   rotulado, depois; 3 a 5 variações de headline e de CTA; `scripts/check-copy.sh` em exit 0 antes de
   entregar. O gate é condição necessária, nunca suficiente.
9. **Mídia nunca por modelo Claude.** Sugestão de imagem é texto (descrição do que o visual mostra).
   Gerar o visual: detecte Codex/Gemini e **pergunte ao usuário qual usar**. Nenhum disponível: diga
   sem rodeio que visual gerado pelo Claude sai ruim de verdade (a qualidade é inversamente proporcional
   à de código, onde o Claude é o melhor) e ofereça alternativas: instalar Codex/Gemini, imagem de
   banco com licença comercial, asset do cliente. Visual da página: `schematize-design`.
10. <!-- herdado:engineering/orquestracao:curto -->**Orquestrador não desenvolve; subagent barato executa.** O agent principal só planeja, despacha e revisa; ação onerosa vira micro-tasks para o executor mais barato que resolve: `haiku` (mecânico) / `sonnet` (código; falhou → mesmo subagent corrige, até 2 rodadas) → Codex `gpt-5.6-terra` → Cursor → subagent `opus` (motivo) → `park`; **visual vai direto ao Codex**; **imagem nunca pelo Claude: detectar Codex/Gemini e perguntar ao usuário qual usar (Codex é a sugestão), nunca API de imagem paga**; papéis em `agentes.toml`. No overdev, cada item do checklist vai a um subagent e o principal revisa antes do `- [x]`. **Sem frota ociosa:** idle com pendência volta ao trabalho; dependente de outro agent → mata e enfileira com gatilho; terminou → mata (§9.6). Detalhe: `schematize-engineering` → `references/orquestracao.md` §9.<!-- /herdado -->

## Relação com as outras skills

- **`schematize-seo-writing`** — texto para ranquear (outline, briefings, keywords); esta skill é para converter. Página que precisa dos dois: o artigo ranqueia, a copy converte, cada uma na sua peça.
- **`schematize-design`** — o visual e a hierarquia da página; esta skill entrega o texto que o design organiza.
- **`schematize-institutional`** — páginas legais e institucionais; copy de venda não substitui termos nem privacidade.
- **`schematize-web`** — onde a copy vira componente e rota; esta skill entrega o texto.
