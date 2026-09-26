#!/usr/bin/env bash
# Genera el EPUB para Kindle Direct Publishing a partir de es.md
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
pandoc es.md -o build/es.epub \
  --from markdown-citations-raw_html+ascii_identifiers \
  --css kindle.css \
  --toc --toc-depth=2 \
  --split-level=1 \
  --syntax-highlighting=pygments
