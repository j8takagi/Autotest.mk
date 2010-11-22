# autotest.mk > template > Group.mk
# テストグループのMakefile
#
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
# テストグループの定義
######################################################################

include Define.mk

# グループディレクトリー
GROUP_DIR := $(shell pwd)

# グループ名。ディレクトリ名から取得
GROUP := $(notdir $(GROUP_DIR))

# テスト名。カレントディレクトリー内の、名前が大文字または.以外で始まるディレクトリー
TESTS = $(notdir $(shell find -maxdepth 1 -name "[^A-Z.]*" -type d))

# テストごとのログファイル
TEST_LOG_FILES := $(foreach test,$(TESTS),$(test)/$(LOG_FILE))

# テストグループログファイル
GROUP_LOG_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]').log

# テストグループレポートファイル
GROUP_REPORT_FILE := Report.log

# 成功したテストの数。テストグループログファイルから取得
SUCCESS_TEST = $(shell grep "^[^A-Z.].*: Test Success" $(GROUP_LOG_FILE) | wc -l)

# 失敗したテストの数。テストグループログファイルから取得
FAIL_TEST = $(shell grep "^[^A-Z.].*: Test Failure" $(GROUP_LOG_FILE) | wc -l)

# すべてのテストの数
ALL_TEST = $(shell expr $(SUCCESS_TEST) + $(FAIL_TEST))

# テストごとの実行時間ファイル
TEST_TIME_FILES := $(foreach test,$(TESTS),$(test)/$(TIME_FILE))

# テストグループ実行時間ファイル
GROUP_TIME_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]')_time.log

######################################################################
# ターゲット
######################################################################

.PHONY: check report create time clean cleanall

check: clean report

report: $(GROUP_REPORT_FILE)
	@$(CAT) $^

$(GROUP_REPORT_FILE): $(GROUP_LOG_FILE)
	@$(call group_report,$(GROUP),$^,$@)

$(GROUP_LOG_FILE): $(TEST_LOG_FILES)
	@$(call group_log,$^,$@)

$(TEST_LOG_FILES):
	@$(MAKE) check -sC $(call dir,$@)

create:
	@$(call create_testdir,$(TEST))
	@$(call create_testmkfile,$(TEST)/$(MAKEFILE))

time: cleantime time_report

time_report: $(GROUP_TIME_FILE)
	@$(CAT) $^

$(GROUP_TIME_FILE): $(TEST_TIME_FILES)
	@$(call group_log,$^,$@)

$(TEST_TIME_FILES):
	@$(MAKE) time -sC $(call dir,$@)

cleantime:
	@$(call make_tests,$(TESTS),$@)
	@$(RM) $(GROUP_TIME_FILE)

clean:
	@$(call make_tests,$(TESTS),$@)
	@$(RM) $(GROUP_REPORT_FILE) $(GROUP_LOG_FILE)
