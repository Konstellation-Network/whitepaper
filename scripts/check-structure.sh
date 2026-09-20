#!/usr/bin/env bash
# Structural checks for the whitepaper source that need no TeX installation.
#   - every \input{...} resolves to a file
#   - every \ref/\eqref target has a matching \label
#   - braces balance in every source file
#   - every \todo{} is listed (informational)
# Usage: scripts/check-structure.sh src/whitepaper.tex
set -euo pipefail

main="${1:-src/whitepaper.tex}"
dir="$(cd "$(dirname "$main")" && pwd)"
fail=0

files=("$main")
while IFS= read -r inc; do
  f="$dir/$inc"
  [[ "$f" == *.tex ]] || f="$f.tex"
  if [[ ! -f "$f" ]]; then echo "MISSING input: $inc" >&2; fail=1; else files+=("$f"); fi
done < <(grep -oE '\\input\{[^}]+\}' "$main" | sed -E 's/\\input\{([^}]+)\}/\1/')

all="$(cat "${files[@]}")"

# labels vs refs
labels="$(printf '%s' "$all" | grep -oE '\\label\{[^}]+\}' | sed -E 's/\\label\{([^}]+)\}/\1/' | sort -u)"
refs="$(printf '%s' "$all" | grep -oE '\\(eq)?ref\{[^}]+\}' | sed -E 's/\\(eq)?ref\{([^}]+)\}/\2/' | sort -u)"
while IFS= read -r r; do
  [[ -z "$r" ]] && continue
  if ! grep -qxF "$r" <<<"$labels"; then echo "UNDEFINED reference: $r" >&2; fail=1; fi
done <<<"$refs"

# brace balance per file (ignores escaped braces and comments)
for f in "${files[@]}"; do
  stripped="$(sed -E 's/\\[{}]//g; s/(^|[^\\])%.*$/\1/' "$f")"
  open="$(printf '%s' "$stripped" | tr -cd '{' | wc -c | tr -d ' ')"
  close="$(printf '%s' "$stripped" | tr -cd '}' | wc -c | tr -d ' ')"
  if [[ "$open" != "$close" ]]; then echo "UNBALANCED braces in $f: { $open vs } $close" >&2; fail=1; fi
done

n_todo="$(printf '%s' "$all" | grep -vE '^\s*%' | grep -oE '\\todo\{' | wc -l | tr -d ' ')"
echo "files: ${#files[@]}, labels: $(wc -l <<<"$labels" | tr -d ' '), refs: $(wc -l <<<"$refs" | tr -d ' '), todo placeholders: $n_todo"
exit $fail
