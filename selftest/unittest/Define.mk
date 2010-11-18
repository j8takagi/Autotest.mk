######################################################################
# テストテンプレートのディレクトリー
######################################################################
# テストグループのMakefileとしてコピーされるファイル
GROUP_MAKEFILE = Group.mk

######################################################################
# テストグループのディレクトリー
######################################################################
# グループディレクトリー
GROUP_DIR = $(shell pwd)

# グループ名。ディレクトリ名から取得
GROUP = $(notdir $(GROUP_DIR))

# テスト名。カレントディレクトリー内の、名前が大文字または.以外で始まるディレクトリー
TESTS = $(notdir $(shell find -maxdepth 1 -name "[^A-Z.]*" -type d))

# テストグループとテストの両方で使う変数を定義したファイル
DEF_FILE = Define.mk

# テストのMakefileにインクルードするファイル
TEST_MAKEFILE = Test.mk

# テストグループログファイル
GROUP_LOG_FILE = $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]').log

# 成功したテストの数。テストグループログファイルから取得
SUCCESS_TEST = $(shell grep "^[^A-Z.].*: Test Success" $(GROUP_LOG_FILE) | wc -l)

# 失敗したテストの数。テストグループログファイルから取得
FAIL_TEST = $(shell grep "^[^A-Z.].*: Test Failure" $(GROUP_LOG_FILE) | wc -l)

# すべてのテストの数
ALL_TEST = $(shell expr $(SUCCESS_TEST) + $(FAIL_TEST))

#テストグループ計時ファイル
GROUP_TIME_FILE = $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]').log

######################################################################
# テストのディレクトリー
######################################################################
# テスト名。カレントディレクトリー名から取得
TEST = $(notdir $(shell pwd))

# 現在の日時
DATE = $(shell date +"%F %T")

# テストコマンドファイル
CMD_FILE = cmd

# テスト説明ファイル
DESC_FILE = desc.txt

# テスト想定結果ファイル
TEST0_FILE = 0.txt

# テスト結果ファイル
TEST1_FILE = 1.txt

# テストの、想定結果と結果の差分ファイル
DIFF_FILE = diff.txt

# テストエラーファイル
ERR_FILE = err.txt

# テストログファイル
LOG_FILE = test.log

# 実行時間ファイル
TIME_FILE = time.log

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

DESC = if test -s $(DESC_FILE); then cat $(DESC_FILE) >>$@; fi;

# 2ファイルの差分を出力。引数は2ファイル
DIFF = diff -c

# ファイルを実行可能にする。引数は1ファイル
CHMOD = chmod u+x

# テスト実行コマンド。
# ファイルの内容と、CMD_FILE実行の標準出力を、ターゲットファイルに保存。
# エラー発生時は、エラー出力をターゲットファイルとERR_FILEに保存。
# ターゲットファイルは、TEST0_FILEまたはTEST1_FILE
CMD = \
    $(CHMOD) $(CMD_FILE); \
    $(CAT) $(CMD_FILE) >$@; \
    ./$(CMD_FILE) >>$@ 2>$(ERR_FILE); \
    if test -s $(ERR_FILE); then $(CAT) $(ERR_FILE) >>$@; else $(RM) $(ERR_FILE); fi

# テストの結果をログに出力
REPORT_TEST = if test ! -s $^; then $(ECHO) "$(TEST): Test Success $(DATE)"  >>$@; else $(ECHO) "$(TEST): Test Failure $(DATE)" >>$@; fi;
