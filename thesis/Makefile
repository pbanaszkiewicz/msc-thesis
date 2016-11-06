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
	@rm *.aux
	@rm *.bbl
	@rm *.bcf
	@rm *.blg
	@rm *.log
	@rm *.out
	@rm *.run.xml
	@rm *.toc
	@rm *.synctex.gz
	@rm *.lof
	@rm *.lot
