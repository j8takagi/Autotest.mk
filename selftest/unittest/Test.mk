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

.PHONY: check set reset time cleantime clean cleanall

check: clean $(LOG_FILE)

set: $(TEST0_FILE)

reset: cleanall $(TEST0_FILE)

time: cleantime $(TIME_FILE)

cleantime:
	@$(RM) $(TIME_FILE)

clean:
	@$(RM) $(TEST1_FILE) $(DIFF_FILE) $(LOG_FILE) $(ERR_FILE) $(TIME_FILE)

cleanall: clean
	@$(RM) $(TEST0_FILE)

$(TEST0_FILE) $(TEST1_FILE): $(CMD_FILE)
	@$(call exec_cmd,$^,$@,$(ERR_FILE))

$(DIFF_FILE): $(TEST1_FILE)
	@-$(DIFF) $(TEST0_FILE) $(TEST1_FILE) >$@ 2>&1

$(LOG_FILE): $(DIFF_FILE)
	@$(DESC)
	@$(REPORT_TEST)

$(TIME_FILE): $(CMD_FILE)
	@$(TIME) ./$(CMD_FILE) 1>/dev/null && $(CAT) $@
