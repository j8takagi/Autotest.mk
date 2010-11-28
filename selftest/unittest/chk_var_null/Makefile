include ../Define.mk
include ../Define_test.mk
include ../Test.mk

.PHONY: utest utest_err

VAR_0 = 0
VAR_1 = 1

utest:
	@$(call chk_var_null,$(VAR_0))
	@$(call chk_var_null,$(VAR_1))
	@echo "VAR_0: $(VAR_0)"
	@echo "VAR_1: $(VAR_1)"
	@echo "VAR_NULL: $(VAR_NULL)"

utest_err:
	@$(call chk_var_null,$(VAR_NULL))
	@echo "VAR_0: $(VAR_0)"
	@echo "VAR_1: $(VAR_1)"
	@echo "VAR_NULL: $(VAR_NULL)"
