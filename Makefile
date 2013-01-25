CAT := cat
GITTAG := git tag
XARGS := xargs

.PHONY: docall gittag

doc:
	$(MAKE) -C doc base

docall:
	$(MAKE) -C doc all

gittag: VERSION
	$(CAT) $^ | $(XARGS) $(GITTAG)

