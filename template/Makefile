# autotest.mk > test_template > Makefile
# テストグループ作成のMakefile
#
# オペレーター
# make            : テストグループディレクトリーを作成
# make creategroup: ↓

include Define.mk

creategroup:
ifndef GROUPDIR
	@echo "no test group created. set GROUPDIR."
else
	@mkdir $(GROUPDIR)
	@cp $(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@cp $(TEST_MAKEFILE) $(GROUPDIR)/
	@cp $(DEF_FILE) $(GROUPDIR)/
endif
