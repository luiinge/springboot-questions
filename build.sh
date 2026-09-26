#!/usr/bin/env bash
# Genera las ediciones para Kindle Direct Publishing a partir de es.md:
#   build/es.epub        ebook (requiere pandoc)
#   build/es-print.pdf   tapa blanda A4 a color con sangrado (requiere pandoc y typst)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
FROM=markdown-citations-raw_html+ascii_identifiers

pandoc es.md -o build/es.epub \
  --from "$FROM" \
  --css kindle.css \
  --toc --toc-depth=2 \
  --split-level=1 \
  --syntax-highlighting=pygments

pandoc es.md -o build/es-print.typ \
  --from "$FROM" \
  --template print.typ \
  --lua-filter print.lua \
  --syntax-highlighting=none \
  --columns=1000
typst compile build/es-print.typ build/es-print.pdf
