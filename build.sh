#!/usr/bin/env bash
# Genera el libro a partir de <idioma>.md:
#   build/<idioma>.pdf         PDF para leer en pantalla (A4, color)
#   build/<idioma>.epub        ebook
#   build/<idioma>-cover.png   portada (primera página del PDF, 300 ppi)
#   build/<idioma>-print.pdf   edición de imprenta con sangrado (solo con --print)
# Requiere pandoc y typst en el PATH.
# Uso: ./build.sh [--print] [es|en ...]   (sin idiomas, todos)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
FROM=markdown-citations-raw_html+ascii_identifiers

PRINT=false
LANGS=()
for arg in "$@"; do
  case "$arg" in
    --print) PRINT=true ;;
    *) LANGS+=("$arg") ;;
  esac
done
[ ${#LANGS[@]} -eq 0 ] && LANGS=(es en)

pdf() {  # pdf <idioma> <edición> <salida>
  pandoc "$1.md" -o "build/$3.typ" \
    --from "$FROM" \
    --template print.typ \
    --lua-filter print.lua \
    --syntax-highlighting=none \
    --columns=1000 \
    -V edition="$2"
  typst compile "build/$3.typ" "build/$3.pdf"
}

for lang in "${LANGS[@]}"; do
  pandoc "$lang.md" -o "build/$lang.epub" \
    --from "$FROM" \
    --css kindle.css \
    --lua-filter epub.lua \
    --toc --toc-depth=2 \
    --split-level=2 \
    --syntax-highlighting=none

  pdf "$lang" screen "$lang"
  typst compile --format png --pages 1 --ppi 300 "build/$lang.typ" "build/$lang-cover.png"
  if $PRINT; then pdf "$lang" print "$lang-print"; fi
done
