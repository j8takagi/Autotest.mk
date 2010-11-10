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

# すべてのテストの数。
ALL_TEST = $(shell expr $(SUCCESS_TEST) + $(FAIL_TEST))

######################################################################
# テストのディレクトリー
######################################################################
# テスト名。カレントディレクトリー名から取得
TEST = $(notdir $(shell pwd))

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

# 現在の日時
DATE = `date +"%F %T"`

# テスト実行コマンド。CMD_FILEを実行する。
# ファイルの内容と、テスト結果を表す標準出力を、ターゲットファイルに保存。
# エラー発生時は、エラー出力をターゲットファイルとERR_FILEに保存。
# ターゲットファイルは、TEST0_FILEまたはTEST1_FILE
CMD = \
    chmod u+x $(CMD_FILE); \
    cat $(CMD_FILE) >$@; \
    ./$(CMD_FILE) >>$@ 2>$(ERR_FILE); \
    if test -s $(ERR_FILE); then cat $(ERR_FILE) >>$@; else rm -f $(ERR_FILE); fi
