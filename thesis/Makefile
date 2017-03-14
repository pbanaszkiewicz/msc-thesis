MAINFILE = 'main'  # no need for the '.tex' ending

all : commands

## commands			: show all commands
commands : Makefile
	@sed -n 's/^## //p' $<

## pdf				: generate PDF
pdf :
	@pdflatex ${MAINFILE} > /dev/null
	@biber ${MAINFILE}
	@pdflatex ${MAINFILE} > /dev/null

## clean				: remove all non-essential LaTeX files
clean :
	@rm *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc *.synctex.gz *.lof *.lot
