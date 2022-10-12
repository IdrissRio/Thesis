.PHONY: count clean

file = thesis

fast: frontpage.pdf
	pdflatex $(file)

all: frontpage.pdf
	pdflatex $(file)
	bibtex $(file)
	pdflatex $(file)
	pdflatex $(file)

frontpage.pdf:
	pdflatex frontpage.tex

count:
	texcount -inc -brief introduction/chapter-introduction.tex
counthtml:
	texcount -v -inc -html implementation.tex > count.html && open count.html
clean:
	rm -rf *.aux frontpage.pdf $(file).pdf $(file).lox $(file).out *.log \
		$(file).toc $(file).tdo *.blg *.synctex.gz \
		*.bbl *.spl *.dvi count.html 
