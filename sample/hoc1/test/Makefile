# autotest.mk > template > Group.mk
# テストグループのMakefile

######################################################################
# テストグループの定義
######################################################################

include Define.mk

# グループディレクトリー
GROUP_DIR := $(shell pwd)

# グループ名。ディレクトリ名から取得
GROUP := $(notdir $(GROUP_DIR))

# テスト名。カレントディレクトリー内の、名前が大文字または.以外で始まるディレクトリー
TESTS := $(notdir $(shell find -maxdepth 1 -name "[^A-Z.]*" -type d))

# 成功したテストの数。テストグループログファイルから取得
SUCCESS_TEST = $(shell grep "^[^A-Z.].*: Test Success" $(GROUP_LOG_FILE) | wc -l)

# 失敗したテストの数。テストグループログファイルから取得
FAIL_TEST = $(shell grep "^[^A-Z.].*: Test Failure" $(GROUP_LOG_FILE) | wc -l)

# すべてのテストの数
ALL_TEST = $(shell expr $(SUCCESS_TEST) + $(FAIL_TEST))

#テストグループ計時ファイル
GROUP_TIME_FILE = $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]')_time.log

######################################################################
# オペレーター
# make         : すべてのテストを実施し、ログファイルを作成
# make check   : ↓
# make create  : TESTNAMEで指定されたテストを新規に作成
# make set     : すべてのテストの、想定結果を出力
# make checkeach: すべてのテストを実施
# make report  : ログファイルから、テストの結果をレポート
# make clean   : すべてのテストで、"make" で生成されたファイルをクリア
# make cleanall: すべてのテストで、"make" と "make set" で生成されたファイルをクリア
######################################################################

.PHONY: check create set checkeach report clean cleanall

check: checkeach report

create:
	@$(call chk_var_null,TEST)
	@$(call chk_file_ext,TEST)
	@$(MKDIR) $(TEST)
	@$(call create_testmkfile,$(TEST)/$(MAKEFILE))

set: $(TESTS)
	$(MAKE) set -C $^

checkeach: $(TESTS)
	@$(RM) $(GROUP_LOG_FILE)
	TARGET=check

$(GROUP_LOG_FILE): $(TESTS)
	@$(LOG_GROUP)

report: $(GROUP_LOG_FILE)
	@$(REPORT_GROUP)

time: timeeach $(GROUP_TIME_FILE)
	@$(CAT) $(GROUP_TIME_FILE)

$(GROUP_TIME_FILE): $(TESTS)
	@$(LOG_TIME_REPORT)

timeeach: $(TESTS)
	@$(MAKE) time -C $^

clean: $(TESTS)
	@echo $^ && $(MAKE) clean -C $^
	@$(RM) $(GROUP_LOG_FILE)

$(TESTS):
	@echo $@
	@$(MAKE) $(TARGET) -C $@
