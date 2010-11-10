# autotest.mk > test_template > test.mk
# 自動テスト用のMakefile
#
# 要: Define.mk
#
# オペレーター
# make         : CMDで設定されたコマンドを実行した出力結果を1.txtに出力し、0.txtと比較し、レポート
# make check   : ↓
# make prepare : CMDで設定されたコマンドを実行した出力結果を0.txt（テストの想定結果）に出力
# make clean   : 「make」で生成されたファイルをクリア
# make cleanall: 「make」と「make prepare」で生成されたファイルをクリア

.PHONY: check set reset clean cleanall

check: clean $(LOG_FILE)

set: $(TEST0_FILE)

reset: cleanall $(TEST0_FILE)

clean:
	@rm -f $(TEST1_FILE) $(DIFF_FILE) $(LOG_FILE) $(ERR_FILE)

cleanall: clean
	@rm -f $(TEST0_FILE)

$(TEST0_FILE) $(TEST1_FILE):
	@if test ! -s $(CMD_FILE); then echo "set command file: $(CMD_FILE)."; else $(CMD); fi

$(DIFF_FILE): $(TEST1_FILE)
	@-diff -c $(TEST0_FILE) $(TEST1_FILE) >$@ 2>&1

$(LOG_FILE): $(DIFF_FILE)
	@if test -s $(DESC_FILE); then cat $(DESC_FILE) >>$@; fi;
	@if test ! -s $^; then echo "$(TEST): Test Success $(DATE)"  >>$@; else echo "$(TEST): Test Failure $(DATE)" >>$@; fi;
