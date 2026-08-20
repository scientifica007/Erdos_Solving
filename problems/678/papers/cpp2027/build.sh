#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
LATEX="${LATEX:-pdflatex}"
BIBTEX="${BIBTEX:-bibtex}"
"$LATEX" -interaction=nonstopmode -halt-on-error main.tex
"$BIBTEX" main
"$LATEX" -interaction=nonstopmode -halt-on-error main.tex
"$LATEX" -interaction=nonstopmode -halt-on-error main.tex
printf '%s\n' 'CPP2027 PAPER BUILD SUCCESS'
