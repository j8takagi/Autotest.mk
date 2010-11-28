include ../Define.mk
include ../Define_test.mk
include ../Test.mk

include ../Define_group.mk

override TEST_RES_FILES := $(TEST_RES_FILES) 0.mk

utest:
	echo $(TEST_INCLUDE_FILES)
	$(call create_makefile,0.mk,$(TEST_MAKEFILES))
