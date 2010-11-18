# autotest.mk > test_template > Makefile
# テストグループ作成のMakefile
#
# オペレーター
# make            : テストグループディレクトリーを作成
# make creategroup: ↓

# 変数やマクロの定義
include Define.mk

# テストグループのMakefileとしてコピーされるファイル
GROUP_MAKEFILE := Group.mk

# テストグループディレクトリーを作成
creategroup:
	@$(call err_var_null,GROUPDIR)
	@$(call err_file_ext,GROUPDIR)
	@$(MKDIR) $(GROUPDIR)
	@$(CP) $(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@$(CP) $(TEST_MAKEFILE) $(GROUPDIR)/
	@$(CP) $(DEF_FILE) $(GROUPDIR)/
