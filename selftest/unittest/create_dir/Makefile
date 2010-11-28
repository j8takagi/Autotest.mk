include ../Define.mk
include ../Define_test.mk
include ../Test.mk
include ../Define_group.mk

.PHONY: utest utest_err clean_utest

override RM := rm -rf
override TEST_RES_FILES := $(TEST_RES_FILES) atest

utest:
	@$(call create_dir,atest)

utest_err:
	@$(call create_dir)

clean_utest:
	@rm -rf atest
