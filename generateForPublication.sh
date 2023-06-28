echo "Generating the publication..."

# store folder name in variable
# FOLDER_NAME=publication

# check if publication folder exists. If not, generate it. If yes, delete it and generate it again
if [ -d "publication" ]; then
  rm -rf publication
fi
mkdir publication

# a list of all tex files in the src folder
TEX_FILES=$(find src -name "*.tex")

# copy all tex files from TEX_FILES from the src folder to the dist folder
for file in $TEX_FILES; do
  cp $file publication/$(basename $file)
done

# copy all the images from the src/img folder to the dist folder
cp src/img/* publication/
cp src/lib/*.bib publication/

# replace all the occurences of the string "src/lib" with "" in all the tex files in the dist folder
sed -i 's/src\/lib\///g' publication/*.tex
sed -i 's/src\/img\///g' publication/*.tex
sed -i 's/src\///g' publication/*.tex

# zip the contents of the publication folder into a tar.gz file

cd publication

pdflatex --output-directory=. main.tex
bibtex main

# safe the content of the main.bbl file into a variable
BBL_CONTENT=$(cat main.bbl)
# delete the line starting with \bibliographystyle in main.tex
sed -i '/\\bibliographystyle/d' main.tex

# insert the content of the main.bbl file into the main.tex file
sed -i '/\\bibliographystyle/d' main.tex
cd ..
python3 replaceLibrary.py publication
cd publication
# sed -i "/\\bibliography{aDistributedPublicationSystem}/i $BBL_CONTENT" main.tex

pdflatex --output-directory=. main.tex
pdflatex --output-directory=. main.tex
rm main.blg main.log main.aux
# copy main.pf into the dist folder and include the date into the pdf name
DATE=$(date +%Y-%m-%d)
cp main.pdf "../dist/published/lakat-$DATE.pdf"
rm main.pdf

tar -czvf publication.tar.gz *