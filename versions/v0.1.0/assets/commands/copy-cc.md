---
description: schematize-copy — context compact: grava o handoff no archive e roda /compact.
---
Antes de compactar, **grave o handoff** em `<projeto>/<projeto>_archive/context/` no par
**context + checklist** do padrão da `schematize-archive` (prefixo `AAAA-MM-DD-<slug>-`), com FEITO vs
ABERTO. Inclua: a tabela de tradução aprovada, o que ficou fora da copy, as peças escritas, a última
saída do `check-copy.sh` (erros e avisos abertos) e os `[PROVA:]`/`[CONFIRMAR:]` pendentes com o
usuário. Só então rode `/compact`.
