######################################################################
# テストグループのディレクトリー
######################################################################
# テストグループとテストの両方で使う変数を定義したファイル
DEF_FILE := Define.mk

# テストのMakefileにインクルードするファイル
TEST_MAKEFILE := Test.mk

# テストグループログファイル
GROUP_LOG_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]').log

# テストグループ実行時間ファイル
GROUP_TIME_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]')_time.log

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

# TESTディレクトリーのMakefileを作成
# 用例: $(call create_testmakefile,file)
define create_testmkfile
    $(RM) $1
    $(foreach mkfile, $(DEF_FILE) $(TEST_MAKEFILE), $(ECHO) "include ../$(mkfile)" >>$1; )
endef

# 説明ファイルの内容を、引数のファイルに出力。
# 用例: $(call desc_log,file_out)
define desc_log
    $(if $(wildcard $(DESC_FILE)),$(CAT) $(DESC_FILE) >>$1)
endef

# テスト実行の経過時間をファイルに出力。引数は、テスト名、コマンドファイル、出力ファイル
# 用例: $(call time_cmd,name,file_cmd,file_out)
define time_cmd
    $(TIME) -f "$1: %E" >>$3 $2>$(DEV_NULL)
    $(CAT) $3
endef

# テスト実行コマンド。引数は、コマンドファイル、出力ファイル、エラーファイル
# ファイルの内容と、CMD_FILE実行の標準出力を、出力ファイルに保存。
# エラー発生時は、エラー出力を出力ファイルとエラーファイルに保存。
# 用例: $(call exec_cmd,file_cmd,file_out,file_err)
define exec_cmd
    $(CHMOD) u+x $1
    $(CAT) $1 >$2
    ./$1 >>$2 2>$3
    if test -s $3; then $(CAT) $3 >>$2; else $(RM) $3; fi
endef

# 2つのファイルを比較し、差分ファイルを作成。引数は、ファイル0、ファイル1、差分ファイル
# 用例: $(call diff_testfiles,file0,file1)
define diff_testfiles
    diff $1 $2 >$3 2>&1
    if test ! -s $3; then $(RM) $3; fi
endef

# 差分ファイルの内容をログファイルに出力。引数は、テスト名、差分ファイル、ログファイル
# 用例: $(call test_log,name,file_diff,file_log)
define test_log
    $(ECHO) "$1: Test $(if $(wildcard $2),Failure,Success) $(DATE)" >>$3
endef

# テストごとのログファイルをグループログファイルに出力。引数は、テストのリスト、グループログファイル
# 用例: $(call group_log_each,tests,file_group_log)
define group_log_each
    $(foreach target,$1,$(call group_log,$(target),$2))
endef

# テストのログファイルをグループログファイルに出力。引数は、テスト、グループログファイル
# 用例: $(call group_log_each,tests,file_group_log)
define group_log
    $(ECHO) >>$2
    if test -s $1/$(LOG_FILE); then $(CAT) $1/$(LOG_FILE) >>$2; else $(ECHO) $1 ": no log." >>$2; fi
endef

LOG_GROUP = for target in $^; do ($(ECHO) <$$target/$(LOG_FILE) && $(CAT) <$$target/$(LOG_FILE)) >>$@ || $(ECHO) $$target ": no log." >>$@; done

REPORT_GROUP = $(ECHO) "$(GROUP): $(SUCCESS_TEST) / $(ALL_TEST) tests passed. Details in `pwd`/$(GROUP_LOG_FILE)"; \
               if test $(FAIL_TEST) -eq 0; then $(ECHO) "$(GROUP): All tests are succeded."; fi

LOG_TIME_REPORT = for target in ^; do ($(ECHO)<$$target/$(LOG_FILE) && $(CAT) <$$target/$(TIME_FILE)) >>$@ || $(ECHO) $$target ": no time." >>$@; done

######################################################################
# エラー
######################################################################

# chk_var_null: 変数がNULLの場合、エラー
# 用例: $(call chk_var_null, var)
define chk_var_null
    $(if $($1),,$(error $1 is NULL))
endef

# chk_file_ext: 変数で指定されたファイルが実在する場合、エラー
# 用例: $(call chk_file_ext, var)
define chk_file_ext
    $(if $(wildcard $($1)),$(error $(wildcard $($1)) exists))
endef
