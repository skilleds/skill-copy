# Firewall do briefing (piso nº 1)

> Parte da `schematize-copy`. O motivo da skill existir. Tudo o que o usuário conta sobre o negócio
> é **insumo**, nunca **texto**.

## 1. O incidente

O usuário disse ao Claude que o plano de negócios da marca Asender era "ticket mais alto que os
concorrentes, foco premium". A copy da landing page saiu com "somos premium, mais caros que a
concorrência". Cada palavra era verdadeira para o dono e inútil, ou prejudicial, para o cliente:
ninguém compra porque o vendedor confessou que cobra mais.

O defeito é clássico de LLM: a copy **fala para dentro**. Ela descreve a estratégia, o posicionamento
e o plano em vez do que o cliente precisa ler para comprar. O modelo trata o briefing como o texto a
ser embelezado, quando ele é a matéria-prima de outro texto.

## 2. A regra

1. **Insumo, não texto.** Plano de negócios, posicionamento, estratégia de preço, ticket, margem,
   público-alvo, persona, concorrentes, metas, jargão interno e "queremos parecer X" entram na
   cabeça de quem escreve e **não saem na página**.
2. **Proibido parafrasear ou citar** o briefing na copy. Trocar "ticket mais alto" por "preço acima da
   média" é a mesma citação com outra roupa.
3. **Tradução obrigatória** de cada fato interno, antes de escrever uma linha de copy:

   `o que o dono me disse -> o que o cliente percebe ou ganha -> como provar na página`

4. Fato interno sem tradução utilizável **fica fora da copy**. Isso é um resultado válido da
   tradução, e deve ser dito ao usuário ("meta de crescimento em SP: fora da copy").
5. A tabela de tradução é entregue **antes** da copy (`/copy-brief`) e é o contrato da copy: tudo o
   que a copy afirma tem linha nela.

## 3. Tabela de exemplos de tradução

| O dono disse (briefing) | O cliente percebe ou ganha | Como provar na página |
|---|---|---|
| Asender: "ticket mais alto que os concorrentes, foco premium". **Nunca** vira "somos premium" nem "mais caros que a concorrência" | Que o preço se justifica: resultado específico, cuidado no atendimento, acabamento, garantia, exclusividade real | Resultado concreto e mensurável no hero; passo a passo do atendimento; fotos e materiais do acabamento; garantia por escrito; limite real de vagas ou de produção (só se for real); depoimento com nome (`[PROVA: ...]` até chegar a fonte); ancoragem de valor **antes** do preço (o que custa o problema, o que está incluído); bloco "Para quem é / para quem não é" que qualifica sem dizer "caro" |
| "Nosso diferencial é a tecnologia X" | O que a tecnologia faz por ele: menos espera, menos erro, mais controle | Antes/depois com número real; demonstração; uma frase de mecanismo em linguagem comum, sem o nome da tecnologia como protagonista |
| "Público B2B de PMEs" | Ser reconhecido: "isto é para o meu tipo de empresa" | Falar a língua do dono da PME (folha, estoque, cliente que atrasa), sem escrever "PME" nem "B2B" |
| "Queremos crescer em SP" | Nada | Nada na copy (meta do dono). Só vira texto se virar fato útil: "atendemos a capital e a Grande SP" |
| "Nossa margem é boa nesse plano" | Nada | Fora da copy |
| "Somos mais baratos que o concorrente Y" | Pagar menos pelo mesmo, ou o que está incluído no preço | Preço claro e o que entra; comparação só se verificável e lícita (`references/legal-br.md`); nunca nomear o concorrente sem base |
| "Queremos parecer uma marca séria" | Confiança: saber quem está por trás e o que acontece se der errado | CNPJ e endereço visíveis, política de troca clara, canal humano de contato, garantia |
| "O funil tem queda no checkout" | Menos atrito para comprar | Resolver no checkout (menos campos, frete antes), e na copy: remover a dúvida que trava (prazo, troca) |
| "Persona: Marina, 34 anos, gerente de RH" | Ser compreendida na situação dela | Cenas e dores dela na linguagem dela, sem escrever "Marina" nem "persona" |
| "Lançamos a versão 3.0 com 40 recursos" | O que mudou na vida dele | Os 2 ou 3 recursos que resolvem a dor principal, como resultado; o resto em lista secundária |

## 4. Como aplicar o caso de preço premium (Asender)

Quando o posicionamento é de ticket alto, a copy **justifica sem citar**:

1. **Resultado específico** logo no hero (o que muda para o cliente, em número ou situação real).
2. **Cuidado visível:** quem atende, em quanto tempo responde, o que acompanha o pedido.
3. **Acabamento e material:** o que se vê e se toca, descrito com precisão.
4. **Garantia:** por escrito, com prazo e condição (CDC e CONAR em `references/legal-br.md`).
5. **Exclusividade só se real:** vagas, lote ou agenda limitados de fato.
6. **Prova:** depoimento, caso, número, selo, sempre com fonte; senão `[PROVA: ...]`.
7. **Ancoragem de valor antes do preço:** o custo do problema, o que está incluído, o que o cliente
   leva; o preço aparece depois, já como proporção do valor.
8. **Quem NÃO é o cliente:** "Se você procura o menor preço, este não é o nosso trabalho" qualifica sem
   dizer "caro" (e só entra se o dono aprovou o tom).

## 5. O que o gate pega e o que não pega

`scripts/check-copy.sh` reprova termos de bastidor (`scripts/termos-bastidor.txt`) e eco de 5 ou
mais palavras do briefing. **Não pega** a paráfrase ("preço acima da média"), o jargão novo que não
está na lista, nem a tradução mal feita. Isso é leitura humana, no `/copy-review`: pergunte, para cada
frase, "isto veio do briefing? o cliente ganha algo ao lê-la?".
