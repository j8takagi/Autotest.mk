include ../Define.mk
include ../Define_test.mk
include ../Test.mk

.PHONY: utest utest_err1 utest_err2

utest:
	@$(call chk_file_notext,a)
	@$(call chk_file_notext,a/a.txt)
	@echo "a: exist"
	@echo "a/a.txt: exist"

utest_err1:
	@$(call chk_file_notext,b)
	@echo "b: not exist"

utest_err2:
	@$(call chk_file_notext,b/b.txt)
	@echo "b/b.txt: not exist"
