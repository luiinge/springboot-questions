#!/usr/bin/env bash
# Genera las ediciones para Kindle Direct Publishing a partir de <idioma>.md:
#   build/<idioma>.epub        ebook (requiere pandoc)
#   build/<idioma>-print.pdf   tapa blanda A4 a color con sangrado (requiere pandoc y typst)
# Uso: ./build.sh [es|en ...]   (sin argumentos, todos los idiomas)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
FROM=markdown-citations-raw_html+ascii_identifiers
LANGS=("$@")
[ ${#LANGS[@]} -eq 0 ] && LANGS=(es en)

for lang in "${LANGS[@]}"; do
  pandoc "$lang.md" -o "build/$lang.epub" \
    --from "$FROM" \
    --css kindle.css \
    --lua-filter epub.lua \
    --toc --toc-depth=2 \
    --split-level=1 \
    --syntax-highlighting=none

  pandoc "$lang.md" -o "build/$lang-print.typ" \
    --from "$FROM" \
    --template print.typ \
    --lua-filter print.lua \
    --syntax-highlighting=none \
    --columns=1000
  typst compile "build/$lang-print.typ" "build/$lang-print.pdf"
done
