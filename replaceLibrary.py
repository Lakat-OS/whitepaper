
# open the main.tex file and replace the occurence of \bibliography{library} with the content of the file library.bib

import os
import re
import sys

argv = sys.argv

publicationDirectory = argv[1]

# replace the pattern \bibliographystyle{\w+} with a variable


def replaceLibrary():
    with open(publicationDirectory + "/main.tex", "r") as f:
        content = f.read()
    with open(publicationDirectory + "/main.bbl", "r") as f:
        library = f.read()
    content = re.sub(r"\\bibliography\{\w+\}", repr(library), content)
    content = content.replace("\\'\\'", "''")
    with open(publicationDirectory + "/main.tex", "w") as f:
        f.write(content)

if __name__ == "__main__":
    replaceLibrary()    