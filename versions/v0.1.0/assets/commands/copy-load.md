---
description: schematize-copy — carrega à força TODO o corpo normativo de copy de conversão e passa a aplicá-lo nesta sessão.
---
Carregue **agora** o corpo normativo da skill `schematize-copy`. A partir daqui, nesta sessão,
isto **não é opcional**.

1. **Leia na íntegra, sem trabalhar de memória.** Caminho:
   `.claude/skills/schematize-copy/references/*.md` (projeto) ou
   `~/.claude/skills/schematize-copy/references/*.md` (global):
   - `firewall-briefing.md` — o piso nº 1, o caso Asender e a tabela de tradução.
   - `leitor-e-estrutura.md` — o leitor é o cliente, estrutura de conversão, AIDA, PAS, 4U, níveis de consciência.
   - `especificidade-prova-voz.md` — clichês banidos, prova nunca inventada, voz do cliente.
   - `legal-br.md` — CDC, CONAR, promessa, escassez falsa, preço claro.
   - `entrega-e-gate.md` — formato da entrega e o que o gate cobre e não cobre.
2. **Leia a fronteira** no `SKILL.md` (artigo SEO, visual, páginas legais, implementação).
3. **Aplique daqui em diante** a todo pedido de copy, e diga qual regra está aplicando quando ela
   mudar o que você ia fazer. Copy só é entregue com `scripts/check-copy.sh` em exit 0.
