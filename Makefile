CAT := cat
GIT := git
PRINTF := printf
WC = wc
XARGS := xargs

VERSION := $(shell $(CAT) VERSION)

VERSIONGITREF := $(shell $(GIT) show-ref -s --tags $(VERSION))

MAINGITREF := $(shell $(GIT) show-ref -s refs/heads/main)

.PHONY: docall gittag version

doc:
	$(MAKE) -C doc base

docall:
	$(MAKE) -C doc all

gittag:
	if test `$(GIT) status -s | $(WC) -l` -gt 0; then $(PRINTF) "Error: commit, first.\n"; exit 1; fi; if test "$(VERSIONGITREF)" != "$(MAINGITREF)"; then $(GIT) tag $(VERSION); fi

version: VERSION
	@$(PRINTF) "Autotest.mk Version: $(VERSION)"
