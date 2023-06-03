#!/bin/bash

# insert the input files into the main.tex

# insert one file into another
sed -i '/\\input{src/abstract}/r src/abstract.tex' src/main.tex

