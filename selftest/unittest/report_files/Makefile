include ../Define.mk
include ../Test.mk

.PHONY: utest utest_err1 utest_err2 clean_utest

override TEST_RES_FILES := $(TEST_RES_FILES) atest
TARGET_FILES := cmd Makefile

utest: clean_utest
	$(call report_files,$(TARGET_FILES),detail.log)

clean_utest:
	$(RM) detail.log
