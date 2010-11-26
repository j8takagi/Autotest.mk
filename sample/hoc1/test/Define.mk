# autotest.mk > test_template > Define.mk
# 自動テスト用の変数、マクロ定義

ifndef DEFINE_INCLUDED
DEFINE_INCLUDED = 1

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

# 現在の日時
DATE = $(shell date +"%F %T")

######################################################################
# コマンド
######################################################################

CP ?= cp

CAT ?= cat

MKDIR ?= mkdir

RM ?= rm -f

ECHO ?= echo

TIME ?= /usr/bin/time --quiet

DIFF ?= diff -c

DEV_NULL ?= /dev/null

CHMOD ?= chmod

######################################################################
# マクロ
######################################################################

# chk_var_null: 引数がNULLの場合、エラー
# 用例: $(call chk_var_null,var)
define chk_var_null
    $(if $1,,$(error NULL argument))
endef

# chk_file_ext: 指定されたファイルが実在する場合、エラー
# 用例: $(call chk_file_ext,file)
define chk_file_ext
    $(if $(wildcard $1),$(error $1 exists in $(CURRDIR)))
endef

# chk_file_notext: 指定されたファイルが実在しない場合、エラー
# 用例: $(call chk_file_notext,file)
define chk_file_notext
    $(if $(wildcard $1),,$(error $1 not exists in $(CURRDIR)))
endef

endif
