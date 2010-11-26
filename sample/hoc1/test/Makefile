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

SHELL = /bin/sh

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

# テストグループログファイル
GROUP_LOG_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]').log

# テストグループレポートファイル
GROUP_REPORT_FILE := Report.log

# テストグループ実行時間ファイル
GROUP_TIME_FILE := $(shell echo $(GROUP) | tr '[a-z]' '[A-Z]')_time.log

# グループで、テスト時に作成されるファイル群
GROUP_TEMP_FILES := $(GROUP_LOG_FILE) $(GROUP_REPORT_FILE) $(GROUP_TIME_FILE)

# テストごとのログファイル
TEST_LOG_FILES := $(foreach test,$(TESTS),$(test)/$(LOG_FILE))

# 指定したディレクトリーを作成
# 用例: $(call create_dir,name)
define create_dir
    $(call chk_var_null,$1)
    $(call chk_file_ext,$1)
    $(MKDIR) $1
endef

# テストごとのMakefileを作成
# 用例: $(call create_makefile,file)
define create_makefile
    $(RM) $1
    $(foreach mkfile,$(DEF_FILE) $(TEST_MAKEFILE),$(ECHO) "include ../$(mkfile)" >>$1; )
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
    if test -s $1; then $(CAT) $1 >>$2; else $(ECHO) $(dir $1)": no log" >>$2; fi
    echo >>$2;

endef

# 成功したテストの数。テストグループログファイルから取得
SUCCESS_TEST = $(shell grep "^[^A-Z.].*: Test Success" $(GROUP_LOG_FILE) | wc -l)

# 失敗したテストの数。テストグループログファイルから取得
FAIL_TEST = $(shell grep "^[^A-Z.].*: Test Failure" $(GROUP_LOG_FILE) | wc -l)

# すべてのテストの数
ALL_TEST = $(shell expr $(SUCCESS_TEST) + $(FAIL_TEST))

# テストごとの実行時間ファイル
TEST_TIME_FILES := $(foreach test,$(TESTS),$(test)/$(TIME_FILE))

# テストの結果を、グループログファイルを元にレポート。
# 引数は、グループログファイル
# 用例: $(call group_report,name,file_log,file_report)
define group_report
    $(ECHO) "$1: $(SUCCESS_TEST) / $(ALL_TEST) tests passed. Details in $(GROUP_DIR)/$2" >$3;
    if test $(FAIL_TEST) -eq 0; then $(ECHO) "$1: All tests are succeded." >>$3; fi
endef

# リストで指定したディレクトリーでmakeを実行
# 用例: $(call make_tests,list_dir,target)
define make_tests
    $(foreach dir,$1,$(call make_test_each,$(dir),$2))
endef

# 指定したディレクトリーでMakeを実行
# 用例: $(call make_test_each,tests,target)
define make_test_each
    $(MAKE) $2 -sC $1;

endef

######################################################################
# ターゲット
######################################################################

.PHONY: check checkall time create clean cleantime

check checkall: clean $(GROUP_REPORT_FILE)
	@$(CAT) $(GROUP_REPORT_FILE)

time: cleantime $(GROUP_TIME_FILE)
	@$(CAT) $(GROUP_TIME_FILE)

create:
	@$(call create_dir,$(TEST))
	@$(call create_makefile,$(TEST)/$(MAKEFILE))

clean:
	@$(call make_tests,$(TESTS),$@)
	@$(RM) $(GROUP_TEMP_FILES)

cleantime:
	@$(call make_tests,$(TESTS),$@)
	@$(RM) $(GROUP_TIME_FILE)

$(GROUP_REPORT_FILE): $(GROUP_LOG_FILE)
	@$(call group_report,$(GROUP),$^,$@)

$(GROUP_LOG_FILE): $(TEST_LOG_FILES)
	@$(call group_log,$^,$@)

$(TEST_LOG_FILES):
	@$(MAKE) $(MAKECMDGOALS) -sC $(dir $@)

$(GROUP_TIME_FILE): $(TEST_TIME_FILES)
	@$(call group_log,$^,$@)

$(TEST_TIME_FILES):
	@$(MAKE) time -sC $(dir $@)
