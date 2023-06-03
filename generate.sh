#!/bin/bash

# Generate the pdflatex
pdflatex --output-directory=src src/main.tex
bibtex src/main
pdflatex --output-directory=src src/main.tex
pdflatex --output-directory=dist src/main.tex
cp dist/main.pdf dist/lakat.pdf
rm dist/main.*
# cp dist/lakat.pdf dist/lakat-$(date +%Y-%m-%d).pdf
# cp dist

