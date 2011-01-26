include ../Define.mk
include ../Test.mk

.PHONY: utest utest_err1 utest_err2

utest:
	@$(call chk_file_ext,b)
	@$(call chk_file_ext,b/b.txt)
	@echo "b: not exist"
	@echo "b/b.txt: not exist"

utest_err1:
	@$(call chk_file_ext,a)
	@echo "a: not exist"

utest_err2:
	@$(call chk_file_ext,a/a.txt)
	@echo "a/a.txt: not exist"

