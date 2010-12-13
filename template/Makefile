# autotest.mk > test_template > Makefile
# テストグループ作成のMakefile
#
# オペレーター
# make         : テストグループディレクトリーを作成し、Makefile群をコピー
# make group   : ↓
# make groupdir: テストグループディレクトリーを作成
# make copymk  : Makefile群をコピー
# make linkmk  : Makefile群をコピー

# 変数やマクロの定義
include Define.mk

# テストグループのMakefileとしてコピーされるファイル
GROUP_MAKEFILE := Group.mk

.PHONY: group groupdir copymk linkmk

MKFILE_METHOD = $(if $(LINKMK),linkmk,copymk)

group: groupdir $(MKFILE_METHOD)

groupdir:
	@$(call err_var_null,GROUPDIR)
	@$(call err_file_ext,GROUPDIR)
	@$(MKDIR) $(GROUPDIR)

copymk:
	@$(CP) $(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@$(CP) $(MAKEFILES) $(GROUPDIR)/

linkmk:
	@$(LINK) $(CURRDIR)/$(GROUP_MAKEFILE) $(GROUPDIR)/Makefile
	@$(LINK) $(MAKEFILES_ABS) $(GROUPDIR)/
