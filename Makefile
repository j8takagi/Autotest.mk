.PHONY: release docbase docall gitpush gittag clean distclean

release: docbase gitpush

docbase:
	$(MAKE) -C doc base

docall:
	$(MAKE) -C doc all

gitpush: gitpush___stamp

gittag: gittag___stamp

include git.mk

distclean: clean

clean: gitclean
	$(MAKE) -C doc clean
