CAT := cat
GIT := git
WC = wc
XARGS := xargs

VERSION := $(shell $(CAT) VERSION)

VERSIONGITREF := $(shell $(GIT) show-ref -s --tags $(VERSION))

MASTERGITREF := $(shell $(GIT) show-ref -s refs/heads/master)

.PHONY: docall gittag version

doc:
	$(MAKE) -C doc base

docall:
	$(MAKE) -C doc all

gittag:
	if test `$(GIT) status -s | $(WC) -l` -gt 0; then $(ECHO) "Error: commit, first."; exit 1; fi; if test "$(VERSIONGITREF)" != "$(MASTERGITREF)"; then $(GIT) tag $(VERSION); fi

version: VERSION
	@$(ECHO) "YACASL2 Version: $(VERSION)"
