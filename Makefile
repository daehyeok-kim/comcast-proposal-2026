SUMM = summary
PROP = proposal

proposal: 
	rm -f $(PROP).pdf *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.dvi *.ps *.out *.run.xml *.synctex.gz *.thm *.toc
	pdflatex $(PROP)
	bibtex $(PROP)
	pdflatex $(PROP)
	pdflatex $(PROP)

	pdfjam $(PROP).pdf 1 -o summary.pdf --paper letterpaper
	pdfjam $(PROP).pdf 2-16 -o description.pdf --paper letterpaper
	pdfjam $(PROP).pdf 17-26 -o references.pdf --paper letterpaper
	pdfjam $(PROP).pdf 27-28 -o data-management.pdf --paper letterpaper
	pdfjam $(PROP).pdf 29 -o facilities.pdf --paper letterpaper
	pdfjam $(PROP).pdf 30-40 -o supplementary.pdf  --paper letterpaper

summary: 
	rm -f $(SUMM).pdf *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.dvi *.ps *.out *.run.xml *.synctex.gz *.thm *.toc
	pdflatex $(SUMM)

clean:
	rm -f $(SUMM).pdf $(PROP).pdf *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.dvi *.ps *.out *.run.xml *.synctex.gz *.thm *.toc

spell: ## run a spell check
	@for i in *.tex; do bin/aspell.sh tex $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex

