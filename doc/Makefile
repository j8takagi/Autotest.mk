DOCNAME = autotest_mk
TEXBIN = /usr/local/texlive/2010/bin/x86_64-linux/
SRC = $(DOCNAME).texi
CSS = style.css
PTEX = $(TEXBIN)/ptex
TEXINDEX = $(TEXBIN)/texindex
DVI2PDF = $(TEXBIN)/dvipdfmx
MAKEINFO = makeinfo

.PHONY: all htmlnosplit pdf clean

.INTERMEDIATE: yacasl2.dvi

all: info htmlnosplit html pdf

htmlnosplit: $(DOCNAME).html

info: $(DOCNAME).info

html: $(SRC) $(CSS)
	@if test ! -s $@; then mkdir $@; fi;
	@cp $(CSS) $@/$(CSS)
	@$(MAKEINFO) -o $@ --html --css-ref=style.css $(SRC)

pdf: $(DOCNAME).pdf

$(DOCNAME).info: $(SRC)
	@$(MAKEINFO) -o $@ $^

$(DOCNAME).html: $(SRC) $(CSS)
	@$(MAKEINFO) -o $@ --no-split --no-headers --html --css-include=$(CSS) $(SRC)

$(DOCNAME).pdf: $(DOCNAME).dvi
	@$(DVI2PDF) $^

$(DOCNAME).dvi: $(SRC)
	@TEX=ptex texi2dvi -q --texinfo=@afourpaper -o $@ $<
	@rm -rf $(DOCNAME).aux $(DOCNAME).cp $(DOCNAME).cps $(DOCNAME).fn $(DOCNAME).ky $(DOCNAME).log $(DOCNAME).pg $(DOCNAME).pgs $(DOCNAME).tmp $(DOCNAME).toc $(DOCNAME).tp $(DOCNAME).vr

clean:
	@rm -rf html $(DOCNAME).info $(DOCNAME).pdf $(DOCNAME).html $(DOCNAME).dvi
