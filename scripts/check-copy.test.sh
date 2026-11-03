#!/usr/bin/env bash
# Vermelho primeiro do gate de copy. Cada caso planta UM defeito (ou o verde) e confere o exit E a mensagem.
#
# EXCEÇÃO DECLARADA (schematize-shell): harness de teste roda `set -u` sem `-e` — precisa continuar
# depois de um caso vermelho para reportar todos, em vez de parar no primeiro.
set -u
AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
C="$AQUI/check-copy.sh"
TMP="$(mktemp -d)"; trap 'rm -rf "${TMP:?}"' EXIT INT TERM
ok=0; fail=0

# O que: indenta a saída do gate nos relatos de falha.
recuar() { local l; while IFS= read -r l; do printf '      %s\n' "$l"; done; }

# caso <nome> <exit-esperado> <agulha> [args extras]   (copy no stdin; briefing via --briefing <arquivo>)
caso() {
  local nome="$1" esp="$2" agulha="$3"; shift 3
  local f="$TMP/$nome.md"; cat > "$f"
  local saida rc
  saida="$(bash "$C" "$f" "$@" 2>&1)"; rc=$?
  if [ "$rc" != "$esp" ]; then echo "  FALHA $nome: exit $rc, esperado $esp"; recuar <<<"$saida"; fail=$((fail + 1)); return; fi
  if [ -n "$agulha" ] && ! grep -qF -- "$agulha" <<<"$saida"; then echo "  FALHA $nome: exit certo, saída sem \"$agulha\""; recuar <<<"$saida"; fail=$((fail + 1)); return; fi
  echo "  ok    $nome"; ok=$((ok + 1))
}

printf 'Endereço: Rua das Flores, 120, sala 4, Centro, de segunda a sexta.\n' > "$TMP/briefing-fato.md"
BRIEFING="$TMP/briefing.md"
cat > "$BRIEFING" <<'B'
O plano de negócios da Asender é ticket mais alto que os concorrentes, foco premium.
Queremos atingir donos de pequenas empresas do interior paulista nos próximos dois anos.
B

VERDE='# Receba o pedido no dia combinado

Você escolhe o dia da entrega e acompanha tudo pelo celular. Se o prazo falhar, você recebe o valor de volta.

Seu pedido sai com embalagem reforçada e nota fiscal. Você fala com uma pessoa, não com um robô.

[Quero escolher meu dia](#comprar)'

echo "== verde de partida =="
caso verde 0 "0 erro(s)" --briefing "$BRIEFING" <<<"$VERDE"
caso verde-sem-briefing 0 "0 erro(s)" <<<"$VERDE"
caso palavra-inteira-nao-casa 0 "0 erro(s)" <<<"Você recebe um atendimento personalizado e leva o seu pedido no mesmo dia."

echo "== vazamento de bastidor (piso nº 1) =="
caso bastidor-asender 1 "ticket mais alto" <<<"Somos uma marca premium com ticket mais alto que os concorrentes. Você merece o melhor."
caso bastidor-concorrentes 1 "concorrentes" <<<"Você leva um produto melhor que os concorrentes."
caso bastidor-concorrencia 1 "concorrencia" <<<"Você paga menos que a concorrência."
caso bastidor-linha 1 ":3:" <<<$'Você escolhe o dia.\n\nNosso posicionamento é claro e você sente a diferença.'
caso bastidor-maiuscula-acento 1 "ticket medio" <<<"VOCÊ paga o TICKET MÉDIO do setor e leva mais."
BRIEF_FUNIL="$TMP/briefing-funil.md"; echo "Aumentar o funil de vendas e a margem do ticket." > "$BRIEF_FUNIL"
caso bastidor-jargao-do-briefing 1 "funil" --briefing "$BRIEF_FUNIL" <<<"Você entra no nosso funil de vendas e recebe uma proposta."
caso contextual-sem-briefing-e-aviso 0 "AVISO contexto" <<<"Sua equipe B2B gerencia o funil de leads da plataforma. Você acompanha tudo."
caso contextual-permitir-libera 0 "0 erro(s)" --briefing "$BRIEF_FUNIL" --permitir funil <<<"Você acompanha o funil de vendas da sua equipe em tempo real."
caso parafrase-preco-asender 1 "bastidor" <<<"Você escolhe a opção premium: o preço fica acima da média do setor porque cuidamos de tudo."

echo "== eco do briefing =="
caso eco-briefing 1 "eco-briefing" --briefing "$BRIEFING" <<<"Você, que quer atingir donos de pequenas empresas do interior, vai gostar."
caso eco-quatro-palavras-passa 0 "0 erro(s)" --briefing "$BRIEFING" <<<"Você atinge donos de pequenas empresas com facilidade, no seu ritmo."

caso fato-marcado-nao-e-eco 0 "0 erro(s)" --briefing "$TMP/briefing-fato.md" <<<"Você nos encontra na <!-- fato -->Rua das Flores, 120, sala 4, Centro<!-- /fato --> de segunda a sexta."
echo "== travessão, emoji, e-mail =="
caso travessao-aviso 0 "AVISO travessao" <<<"Você recebe tudo — no prazo combinado."
caso emoji-aviso 0 "AVISO emoji" <<<"Você começa hoje 🚀 e recebe no prazo."
caso email-sem-descadastro 0 "AVISO email" --email <<<"Você recebe a oferta do mês no seu e-mail."
caso email-com-descadastro 0 "0 aviso(s)" --email <<<$'Você recebe a oferta do mês.\n{{unsubscribe}}'

echo "== clichê de IA =="
caso cliche-revolucionario 1 "cliche" <<<"Você conhece a solução revolucionária que muda o seu dia."
caso cliche-nao-e-apenas 1 "cliche" <<<"Seu pedido não é apenas uma caixa, é uma promessa cumprida para você."
caso cliche-trinca 1 "cliche" <<<"Você usa um sistema rápido, simples e seguro."

echo "== razão nós/você =="
caso razao-nos 1 "razao-nos-voce" <<<"Nós somos a equipe que cuida de tudo. Nosso time e nossa fábrica trabalham para você."
caso razao-igual-passa 0 "0 erro(s)" <<<"Nós entregamos. Você recebe."

echo "== prova pendente (aviso, não reprova) =="
caso prova-aviso 0 "AVISO prova" <<<$'Você vê o resultado na primeira semana.\n\n[PROVA: depoimento de cliente com nome e cidade]'

echo "== nada para verificar (exit 2) =="
: > "$TMP/vazio.md"
caso vazio 2 "nada para verificar" < "$TMP/vazio.md"
caso so-espacos 2 "nada para verificar" <<<$'  \n\n'
r="$(bash "$C" "$TMP/nao-existe.md" 2>&1)"; rc=$?
if [ "$rc" = 2 ]; then echo "  ok    arquivo-inexistente"; ok=$((ok + 1)); else echo "  FALHA arquivo-inexistente: exit $rc ($r)"; fail=$((fail + 1)); fi
: > "$TMP/brief-vazio.md"
caso briefing-vazio 2 "briefing" --briefing "$TMP/brief-vazio.md" <<<"$VERDE"

echo
echo "$ok ok, $fail falha(s)"
[ "$fail" = 0 ]
