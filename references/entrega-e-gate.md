# Entrega e gate

> Parte da `schematize-copy`. Como a copy é entregue e o que a máquina confere antes.

## 1. Entrega (piso nº 8)

1. **A copy final vem limpa**, sem racional embutido: nada de "(isso reforça a autoridade)" no meio
   do texto, nada de nota de estratégia, nada de rótulo de framework dentro da página.
2. O **racional** (por que cada escolha) vem **depois**, num bloco separado e rotulado
   ("Racional, não faz parte da copy").
3. **3 a 5 variações** de headline e de CTA, com ângulos diferentes (benefício, dor, prova, curiosidade
   específica, objeção), cada uma com uma linha dizendo o ângulo no bloco de racional.
4. Ordem da resposta: (a) tabela de tradução do briefing (resumo), (b) a copy limpa, (c) variações,
   (d) racional, (e) pendências: `[PROVA:]`, `[CONFIRMAR:]`, itens para validação legal, (f) saída do
   gate.

## 2. O gate: `scripts/check-copy.sh`

```
bash scripts/check-copy.sh <copy.md|txt> [--briefing <briefing.md>]
```

Exit `0` passa, `1` reprova (lista cada achado com a linha), `2` nada para verificar (**não é
aprovação**: arquivo vazio, inexistente ou briefing vazio).

| Regra | O que reprova | Nível |
|---|---|---|
| `bastidor` | Termo de estratégia interna na copy (`scripts/termos-bastidor.txt`: "plano de negócios", "ticket mais alto", "posicionamento", "persona", "funil", "lead", "B2B", "somos premium"...). Sem acento ou caixa; palavra inteira. | ERRO |
| `eco-briefing` | 5 ou mais palavras seguidas do briefing (normalizadas) aparecem na copy. Só com `--briefing`. | ERRO |
| `cliche` | Clichê de IA (`scripts/cliches.txt`). | ERRO |
| `razao-nos-voce` | Mais ocorrências de nós/nosso(s)/nossa(s)/somos/a gente que de você/seu(s)/sua(s). | ERRO |
| `prova` | Marcador `[PROVA:` aberto. | AVISO |

Rode **sempre com `--briefing`** quando houver briefing escrito: é o que pega o eco.

## 3. O que o gate NÃO cobre (leitura obrigatória)

- Paráfrase do briefing e jargão fora das listas (firewall, `references/firewall-briefing.md`).
- Se a tradução é boa: se o cliente percebe o que o dono quis dizer.
- Especificidade real, promessa sem objeto, clichê fora da lista.
- Prova inventada que parece real (só a fonte do usuário garante).
- Promessa de resultado, escassez falsa, comparação (`references/legal-br.md`).
- Coerência anúncio -> página e o tom da marca.

Exit 0 do gate é condição **necessária** para entregar, nunca suficiente.

## 4. Como estender as listas

Acrescente uma linha em `scripts/termos-bastidor.txt` ou `scripts/cliches.txt` e um caso vermelho em
`scripts/check-copy.test.sh`. Termo que gerou falso positivo na copy de um cliente real é motivo
para refinar com `re:` (regex), não para apagar a regra.
