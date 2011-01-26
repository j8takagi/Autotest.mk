include ../Define.mk
include ../Test.mk

.PHONY: utest clean_utest

utest: clean_utest
	$(call exec_cmd,cmd0,00.txt,err.txt)

clean_utest:
	$(RM) 00.txt err.txt
