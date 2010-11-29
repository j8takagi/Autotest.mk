# autotest.mk > test_template > Makefile
# テストグループ作成のMakefile
#
# オペレーター
# make               : テストグループディレクトリーを作成し、Makefile群をコピー
# make creategroup   : ↓
# make creategroupdir: テストグループディレクトリーを作成
# make copymakefile  : Makefile群をコピー

# 変数やマクロの定義
include Define.mk

# テストグループのMakefileとしてコピーされるファイル
GROUP_MAKEFILE := Group.mk

.PHONY: creategroup creategroupdir copymakefiles linkmakefiles

MKFILE_METHOD = $(if $(LINK),linkmk,copymk)

creategroup: creategroupdir $(MKFILE_METHOD)

creategroupdir:
	@$(call err_var_null,GROUPDIR)
	@$(call err_file_ext,GROUPDIR)
	@$(MKDIR) $(GROUPDIR)

copymk:
	@$(CP) $(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@$(CP) $(MAKEFILES) $(GROUPDIR)/

linkmk:
	@$(LINK) $(CURRDIR)/$(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@$(LINK) $(MAKEFILES_ABS) $(GROUPDIR)/
