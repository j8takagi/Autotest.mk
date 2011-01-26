include ../Define.mk
include ../Test.mk

.PHONY: utest utest_err clean_utest

override RM := rm -rf
override TEST_RES_FILES := $(TEST_RES_FILES) atest

utest:
	@$(call create_dir,atest)

utest_err:
	@$(call create_dir)

clean_utest:
	@rm -rf atest
