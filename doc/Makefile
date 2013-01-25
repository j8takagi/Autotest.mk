DOC := autotest_mk
CSS := style.css
SAMPLE := sample

MKDIR := mkdir -p
RMRF := rm -rf
RSYNC := rsync

.PHONY: base all clean

base: $(DOC).info $(DOC).html

all: base $(DOC)_html $(DOC).pdf

$(DOC).html: $(SAMPLE)

$(SAMPLE): $(SAMPLE)/triangle $(SAMPLE)/sort

$(SAMPLE)/triangle: ../sample/triangle/test
	if test ! -e $(dir $@); then $(MKDIR) $(dir $@); fi
	$(RSYNC) -az $</ $@

$(SAMPLE)/sort: ../sample/sort/test
	if test ! -e $(dir $@); then $(MKDIR) $(dir $@); fi
	$(RSYNC) -az $</ $@

$(DOC)_html: $(DOC)_html/$(SAMPLE)

$(DOC)_html/$(SAMPLE): $(SAMPLE)
	if test ! -e $(dir $@); then $(MKDIR) $(dir $@); fi
	$(RSYNC) -az $</ $@

include texinfo.mk

distclean: texinfo-distclean
	$(RMRF) $(DOC).info $(DOC).html $(SAMPLE) $(DOC)_html $(DOC).pdf

clean: texinfo-clean
