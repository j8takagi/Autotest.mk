GITTAG := git tag

.PHONY: gittag

gittag: VERSION
	$(CAT) $^ | $(XARGS) $(GITTAG)
