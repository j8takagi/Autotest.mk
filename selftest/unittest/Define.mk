######################################################################
# テストグループのディレクトリー
######################################################################
# テストグループとテストの両方で使う変数を定義したファイル
DEF_FILE := Define.mk

# テストのMakefileにインクルードするファイル
TEST_MAKEFILE := Test.mk

######################################################################
# テストのディレクトリー
######################################################################
# Makefile
MAKEFILE := Makefile

# 現在の日時
DATE = $(shell date +"%F %T")

# テストコマンドファイル
CMD_FILE := cmd

# テスト説明ファイル
DESC_FILE := desc.txt

# テスト想定結果ファイル
TEST0_FILE := 0.txt

# テスト結果ファイル
TEST1_FILE := 1.txt

# テストの、想定結果と結果の差分ファイル
DIFF_FILE := diff.txt

# テストエラーファイル
ERR_FILE := err.txt

# テストログファイル
LOG_FILE := test.log

# 実行時間ファイル
TIME_FILE := time.log

######################################################################
# コマンド
######################################################################

CP := cp

CAT := cat

MKDIR := mkdir

RM := rm -f

ECHO := echo

TIME := /usr/bin/time

DIFF := diff -c

DEV_NULL := /dev/null

CHMOD := chmod

######################################################################
# エラー
######################################################################

# chk_var_null: 変数がNULLの場合、エラー
# 用例: $(call chk_var_null,var)
define chk_var_null
    $(if $1,,$(error NULL argument))
endef

# chk_file_ext: 変数で指定されたファイルが実在する場合、エラー
# 用例: $(call chk_file_ext,var)
define chk_file_ext
    $(if $(wildcard $1),$(error $(wildcard $1) exists))
endef

######################################################################
# マクロ
######################################################################

# 指定したディレクトリーを作成
# 用例: $(call create_testdir,name)
define create_testdir
    $(call chk_var_null,$1)
    $(call chk_file_ext,$1)
    $(MKDIR) $1
endef

# TESTディレクトリーのMakefileを作成
# 用例: $(call create_testmakefile,file)
define create_testmkfile
    $(RM) $1
    $(foreach mkfile,$(DEF_FILE) $(TEST_MAKEFILE),$(ECHO) "include ../$(mkfile)" >>$1; )
endef

# リストで指定したディレクトリーでMakeを実行
# 用例: $(call make_tests,list_dir,target)
define make_tests
    $(foreach dir,$1,$(call make_test_each,$(dir),$2))
endef

# 指定したディレクトリーでMakeを実行
# 用例: $(call make_test_each,tests,target)
define make_test_each
    $(MAKE) $2 -sC $1;

endef

# 引数のファイルをチェックし、内容がない場合は削除
# 用例: $(call rm_null,file)
define rm_null
    if test ! -s $1; then $(RM) $1; fi
endef

# 説明ファイルの内容を、引数のファイルに出力。
# 用例: $(call desc_log,file_out)
define desc_log
    if test -s $(DESC_FILE); then $(CAT) $(DESC_FILE) >>$1; fi
endef

# テスト実行の経過時間を、ファイルに出力して表示。
# 引数は、テスト名、コマンドファイル、出力ファイル
# 用例: $(call time_cmd,name,file_cmd,file_out)
define time_cmd
    $(TIME) -f"$1: %E" -o $3 ./$2 >$(DEV_NULL)
endef

# テスト実行コマンド。引数は、コマンドファイル、出力ファイル、エラーファイル
# ファイルの内容と、CMD_FILE実行の標準出力を、出力ファイルに保存。
# エラー発生時は、エラー出力を出力ファイルとエラーファイルに保存。
# 用例: $(call exec_cmd,file_cmd,file_out,file_err)
define exec_cmd
    $(CHMOD) u+x $1
    $(CAT) $1 >$2
    ./$1 >>$2 2>$3
    if test -s $3; then $(CAT) $3 >>$2; fi
    $(call rm_null,$3)
endef

# 2つのファイルを比較し、差分ファイルを作成。
# 引数は、ファイルのリスト（セパレーターは空白）、差分ファイル
# 用例: $(call diff_files,files,file_out)
define diff_files
    $(DIFF) $1 >$2 2>&1
    $(call rm_null,$2)
endef

# 差分ファイルの内容をログファイルに出力。
# 引数は、テスト名、差分ファイル、ログファイル
# 用例: $(call test_log,name,file_diff,file_log)
define test_log
    if test ! -s $2; then RES=Success; else RES=Failure; fi; $(ECHO) "$1: Test $$RES $(DATE)" >>$3
endef

# テストごとのファイルをグループファイルに出力
# 引数は、テストのリスト、グループファイル、テストファイル
# 用例: $(call group_log,files_test_log,file_group_log)
define group_log
    $(foreach target,$1,$(call group_log_each,$(target),$2))
endef

# テストのログファイルをグループログファイルに出力。引数は、テスト、グループログファイル
# 用例: $(call group_log_each,file_test_log,file_group_log)
define group_log_each
    if test -s $1; then $(CAT) $1 >>$2; else $(ECHO) $(dir $1): no log >>$2; fi
    echo >>$2;

endef

# テストの結果を、グループログファイルを元にレポート。
# 引数は、グループログファイル
# 用例: $(call group_report,name,file_log_file_report)
define group_report
    $(ECHO) "$1: $(SUCCESS_TEST) / $(ALL_TEST) tests passed. Details in $2" >$3;
    if test $(FAIL_TEST) -eq 0; then $(ECHO) "$1: All tests are succeded." >>$3; fi
endef
