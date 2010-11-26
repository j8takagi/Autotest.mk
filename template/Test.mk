# autotest.mk > test_template > Test.mk
# 自動テスト用のMakefile
#
# 要: Define.mk
#
# オペレーター
# make         : CMDの標準出力をTEST1_FILEに保存したあと、TEST0_FILEとの差分を比較し、結果をLOG_FILEに出力
# make check   : ↓
# make set     : CMDの標準出力をTEST0_FILEに保存。TEST0_FILEが存在する場合は実行しない
# make reset   : CMDの標準出力をTEST0_FILEに保存。TEST0_FILEが存在する場合は上書き
# make time    : CMDの実行にかかった時間をTIME_FILEに保存し、出力
# make cleantime: "make time" で作成されたファイルをクリア
# make clean   : "make" で作成されたファイルをクリア
# make cleanall: "make" と "make set" で作成されたファイルをクリア

SHELL = /bin/sh

######################################################################
# マクロ
######################################################################

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
    $(call chk_file_notext,$2)
    $(CHMOD) u+x $2
    $(TIME) -f"$1: %E" -o $3 ./$2 >$(DEV_NULL) 2>&1
endef

# テスト実行コマンド。引数は、コマンドファイル、出力ファイル、エラーファイル
# ファイルの内容と、CMD_FILE実行の標準出力を、出力ファイルに保存。
# エラー発生時は、エラー出力を出力ファイルとエラーファイルに保存。
# 用例: $(call exec_cmd,file_cmd,file_out,file_err)
define exec_cmd
    $(call chk_file_notext,$1)
    $(CAT) $1 >$2
    $(CHMOD) u+x $1
    ./$1 >>$2 2>$3
    if test -s $3; then $(CAT) $3 >>$2; fi
    $(call rm_null,$3)
endef

# 2つのファイルを比較し、差分ファイルを作成。
# 引数は、2ファイルのリスト、差分ファイル
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

# テスト名。カレントディレクトリー名から取得
TEST = $(notdir $(shell pwd))

######################################################################
# ターゲット
######################################################################

.PHONY: check set reset time cleantime clean cleanall

check: clean $(LOG_FILE)

checkall: check $(TIME_FILE)
	@$(CAT) $(TIME_FILE) >>$(LOG_FILE)

set: $(TEST0_FILE)
	@$(CAT) $^

reset: cleanall $(TEST0_FILE)
	@$(CAT) $(TEST0_FILE)

time: cleantime $(TIME_FILE)

cleantime:
	@$(RM) $(TIME_FILE)

clean:
	@$(RM) $(TEST1_FILE) $(DIFF_FILE) $(LOG_FILE) $(ERR_FILE) $(TIME_FILE)

cleanall: clean
	@$(RM) $(TEST0_FILE)

$(CMD_FILE):
	@$(call chk_file_notext,$@)
	@$(CHMOD) u+x $@

$(TEST0_FILE) $(TEST1_FILE): $(CMD_FILE)
	@-$(call exec_cmd,$^,$@,$(ERR_FILE))

$(DIFF_FILE): $(TEST0_FILE) $(TEST1_FILE)
	@-$(call diff_files,$^,$@)

$(LOG_FILE): $(DIFF_FILE)
	@$(RM) $@
	@$(call desc_log,$@)
	@$(call test_log,$(TEST),$^,$@)

$(TIME_FILE): $(CMD_FILE)
	@-$(call time_cmd,$(TEST),$^,$@)
