CAT := cat
GITTAG := git tag
XARGS := xargs

.PHONY: docall gittag

gittag: VERSION
	$(CAT) $^ | $(XARGS) $(GITTAG)

docall:
	$(MAKE) -C doc all
