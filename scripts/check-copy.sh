#!/usr/bin/env bash
# check-copy.sh — gate executável da schematize-copy: a copy fala ao cliente, não ao dono do negócio.
#
# Motivo: LLM escreve copy que "fala para dentro". O dono disse "ticket mais alto, foco premium" e a
# landing page saiu com "somos premium, mais caros que a concorrência". O briefing é INSUMO, nunca
# texto; este gate pega o vazamento por máquina antes de a copy ser entregue.
# Como funciona: normaliza a copy (minúsculo, sem acento, linhas preservadas) e aplica 5 checagens:
#   bastidor  termo de estratégia interna (scripts/termos-bastidor.txt)             -> ERRO
#   eco       5+ palavras seguidas do briefing reaparecem na copy (com --briefing)  -> ERRO
#   cliche    clichê de IA (scripts/cliches.txt)                                    -> ERRO
#   razao     ocorrências de "nós/nosso/somos/a gente" maiores que as de "você/seu" -> ERRO
#   prova     marcador [PROVA: ...] ainda aberto                                    -> AVISO
# Entrada: $1 = copy (.md/.txt) · --briefing <arquivo> opcional.
# Saída: `arquivo:linha: [ERRO|AVISO regra] mensagem`; exit 0 passa (avisos não reprovam) ·
#   1 reprova · 2 nada para verificar (não é aprovação).
set -euo pipefail
export LC_ALL=C

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

uso() { echo "uso: check-copy.sh <copy.md|txt> [--briefing <briefing.md>]" >&2; }

# O que: minúsculo + sem acento, linha a linha (a numeração de linha da entrada é preservada).
# Alternação em vez de colchete: em locale C o colchete quebraria o UTF-8 byte a byte.
norm() {
  sed -e 's/\(Á\|À\|Â\|Ã\|Ä\|á\|à\|â\|ã\|ä\)/a/g' \
      -e 's/\(É\|È\|Ê\|Ë\|é\|è\|ê\|ë\)/e/g' \
      -e 's/\(Í\|Ì\|Î\|Ï\|í\|ì\|î\|ï\)/i/g' \
      -e 's/\(Ó\|Ò\|Ô\|Õ\|Ö\|ó\|ò\|ô\|õ\|ö\)/o/g' \
      -e 's/\(Ú\|Ù\|Û\|Ü\|ú\|ù\|û\|ü\)/u/g' \
      -e 's/\(Ç\|ç\)/c/g' -e 's/\(Ñ\|ñ\)/n/g' \
    | tr '[:upper:]' '[:lower:]'
}

# O que: como norm, mas antes protege o pronome "nós" (que sem acento se confundiria com "nos").
norm_nos() {
  sed -e 's/\(N\|n\)\(Ó\|ó\)\(S\|s\)/nosx/g' | norm
}

# O que: converte um arquivo de dados (um termo por linha) em padrões ERE, um por linha.
# Linha comum = frase literal entre \b; "re:" = regex verbatim; "#" e vazias são ignoradas.
construir_padroes() {
  local fonte="$1" linha
  norm < "$fonte" | while IFS= read -r linha || [ -n "$linha" ]; do
    case "$linha" in
      ''|'#'*) continue ;;
      're:'*) printf '%s\n' "${linha#re:}" ;;
      *) printf '\\b%s\\b\n' "$linha" ;;
    esac
  done
}

ARQ=""; BRIEFING=""
while [ $# -gt 0 ]; do
  case "$1" in
    --briefing) [ $# -ge 2 ] || { uso; exit 2; }; BRIEFING="$2"; shift 2 ;;
    -h|--help) uso; exit 2 ;;
    -*) echo "check-copy: opção desconhecida: $1" >&2; uso; exit 2 ;;
    *) [ -z "$ARQ" ] || { uso; exit 2; }; ARQ="$1"; shift ;;
  esac
done

[ -n "$ARQ" ] || { uso; exit 2; }
[ -f "$ARQ" ] || { echo "check-copy: '$ARQ' não existe — nada para verificar" >&2; exit 2; }
grep -q '[^[:space:]]' "$ARQ" || { echo "check-copy: '$ARQ' está vazio — nada para verificar" >&2; exit 2; }
if [ -n "$BRIEFING" ]; then
  [ -f "$BRIEFING" ] || { echo "check-copy: briefing '$BRIEFING' não existe — nada para verificar" >&2; exit 2; }
  grep -q '[^[:space:]]' "$BRIEFING" || { echo "check-copy: briefing '$BRIEFING' está vazio — nada para verificar" >&2; exit 2; }
fi
for dados in termos-bastidor.txt cliches.txt; do
  [ -f "$AQUI/$dados" ] || { echo "check-copy: falta $AQUI/$dados" >&2; exit 2; }
done

TMP="$(mktemp -d)"; trap 'rm -rf "${TMP:?}"' EXIT INT TERM

norm < "$ARQ" > "$TMP/copy.n"
norm_nos < "$ARQ" > "$TMP/copy.nos"
construir_padroes "$AQUI/termos-bastidor.txt" > "$TMP/bastidor.pat"
construir_padroes "$AQUI/cliches.txt" > "$TMP/cliches.pat"

erros=0; avisos=0
# O que: imprime um achado no formato do catálogo e conta.
achado() { # nivel regra linha mensagem
  printf '%s:%s: [%s %s] %s\n' "$ARQ" "$3" "$1" "$2" "$4"
  if [ "$1" = ERRO ]; then erros=$((erros + 1)); else avisos=$((avisos + 1)); fi
}

# 1. Vazamento de bastidor
while IFS=: read -r ln termo; do
  achado ERRO bastidor "$ln" "termo de estratégia interna na copy: \"$termo\" (o briefing é insumo, nunca texto; traduza para o que o cliente percebe)"
done < <(grep -noE -f "$TMP/bastidor.pat" "$TMP/copy.n" || true)

# 2. Eco do briefing: 5+ palavras seguidas
if [ -n "$BRIEFING" ]; then
  norm < "$BRIEFING" > "$TMP/briefing.n"
  while IFS=: read -r ln trecho; do
    achado ERRO eco-briefing "$ln" "trecho do briefing repetido na copy (5+ palavras seguidas): \"$trecho\""
  done < <(awk '
    function toks(s, arr) { gsub(/[^a-z0-9]+/, " ", s); return split(s, arr, " ") }
    FNR == NR { n = toks($0, a); for (i = 1; i <= n; i++) B[++nb] = a[i]; next }
    { n = toks($0, a); for (i = 1; i <= n; i++) { C[++nc] = a[i]; L[nc] = FNR } }
    END {
      for (i = 1; i + 4 <= nb; i++) G[B[i] " " B[i+1] " " B[i+2] " " B[i+3] " " B[i+4]] = 1
      i = 1
      while (i + 4 <= nc) {
        if ((C[i] " " C[i+1] " " C[i+2] " " C[i+3] " " C[i+4]) in G) {
          e = i + 4
          while (e + 1 <= nc && ((C[e-3] " " C[e-2] " " C[e-1] " " C[e] " " C[e+1]) in G)) e++
          t = C[i]; for (k = i + 1; k <= e; k++) t = t " " C[k]
          printf "%d:%s\n", L[i], t
          i = e + 1
        } else i++
      }
    }' "$TMP/briefing.n" "$TMP/copy.n")
fi

# 3. Clichê de IA
while IFS=: read -r ln termo; do
  achado ERRO cliche "$ln" "clichê: \"$termo\" (troque por número, prazo ou nome concreto e real)"
done < <(grep -noE -f "$TMP/cliches.pat" "$TMP/copy.n" || true)

# 4. Razão nós/você
contagem="$(awk '
  { gsub(/[^a-z0-9]+/, " "); n = split($0, w, " ")
    for (i = 1; i <= n; i++) {
      t = w[i]
      if (t == "nosx" || t == "nosso" || t == "nossos" || t == "nossa" || t == "nossas" || t == "somos") nos++
      else if (t == "a" && w[i+1] == "gente") nos++
      if (t == "voce" || t == "voces" || t == "seu" || t == "seus" || t == "sua" || t == "suas") voce++
    } }
  END { printf "%d %d\n", nos, voce }' "$TMP/copy.nos")"
nos="${contagem% *}"; voce="${contagem#* }"
if [ "$nos" -gt "$voce" ]; then
  achado ERRO razao-nos-voce 0 "a copy fala de si: $nos ocorrência(s) de nós/nosso/somos/a gente contra $voce de você/seu/sua (o leitor é o cliente)"
fi

# 5. Prova pendente
while IFS=: read -r ln resto; do
  achado AVISO prova "$ln" "prova pendente, precisa de fonte real do usuário antes de publicar: ${resto:0:80}"
done < <(grep -n '\[PROVA:' "$ARQ" || true)

echo "check-copy: $erros erro(s), $avisos aviso(s)"
[ "$erros" -eq 0 ]
