DOCNAME = autotest_mk
SRC = $(DOCNAME).texi
CSS = style.css
SAMPLES = sample_triangle sample_sort

PTEX = ptex
TEXINDEX = texindex
DVI2PDF = dvipdfmx
MAKEINFO = makeinfo

.PHONY: all htmlnosplit pdf clean

.INTERMEDIATE: yacasl2.dvi

all: info htmlnosplit html pdf

htmlnosplit: $(DOCNAME).html

info: $(DOCNAME).info

html: $(SRC) $(CSS) $(SAMPLES)
	@if test ! -s $@; then mkdir $@; fi;
	@cp $(CSS) $@/
	@cp -r $(SAMPLES) $@/
	@$(MAKEINFO) -o $@ --html --css-ref=style.css $(SRC)

pdf: $(DOCNAME).pdf

$(DOCNAME).info: $(SRC)
	@$(MAKEINFO) -o $@ $^

$(DOCNAME).html: $(SRC) $(CSS)
	@$(MAKEINFO) -o $@ --no-split --html --css-include=$(CSS) $(SRC)

$(DOCNAME).pdf: $(DOCNAME).dvi
	@$(DVI2PDF) $^

$(DOCNAME).dvi: $(SRC)
	@TEX=ptex texi2dvi -q --texinfo=@afourpaper -o $@ $<
	@rm -rf $(DOCNAME).aux $(DOCNAME).cp $(DOCNAME).cps $(DOCNAME).fn $(DOCNAME).ky $(DOCNAME).log $(DOCNAME).pg $(DOCNAME).pgs $(DOCNAME).tmp $(DOCNAME).toc $(DOCNAME).tp $(DOCNAME).vr

$(DOCNAME).xml: $(SRC)
	@$(MAKEINFO) -o $@ --docbook $(SRC)

clean:
	@rm -rf html $(DOCNAME).info $(DOCNAME).pdf $(DOCNAME).html $(DOCNAME).dvi $(DOCNAME).xml
