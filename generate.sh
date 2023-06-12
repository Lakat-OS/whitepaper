#!/bin/bash

# Generate the pdflatex
pdflatex --output-directory=src src/main.tex
bibtex src/main
pdflatex --output-directory=src src/main.tex
pdflatex --output-directory=src src/main.tex
cp src/main.pdf dist/lakat.pdf
cp src/main.tex src/temp_main.tex
rm src/main.*
cp src/temp_main.tex src/main.tex
rm src/temp_main.tex
# cp dist/lakat.pdf dist/lakat-$(date +%Y-%m-%d).pdf
# cp dist

