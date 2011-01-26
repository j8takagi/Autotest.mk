include ../Define.mk
include ../Test.mk

override TEST_RES_FILES := $(TEST_RES_FILES) 0.mk

utest:
	echo $(TEST_INCLUDE_FILES)
	$(call create_makefile,0.mk,$(MAKEFILES))
