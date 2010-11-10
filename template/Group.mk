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

include Define.mk

.PHONY: check create set checkeach report clean cleanall

check: checkeach report

create:
ifndef TEST
	@echo "no test created. set TEST."
else
	@mkdir $(TEST)
	@for ifile in $(DEF_FILE) $(TEST_MAKEFILE); do echo "include ../$$ifile" >>$(TEST)/Makefile; done
endif

set:
	@for target in $(TESTS); do $(MAKE) set -C $$target; done

checkeach:
	@rm -f $(GROUP_LOG_FILE)
	@for target in $(TESTS); do $(MAKE) check -C $$target; done

$(GROUP_LOG_FILE):
	@for target in $(TESTS); do cat <$$target/$(LOG_FILE) >>$@ || echo $$target ": no log." >>$@; done

report: $(GROUP_LOG_FILE)
	@echo "$(GROUP): $(SUCCESS_TEST) / $(ALL_TEST) tests passed. Details in `pwd`/$(GROUP_LOG_FILE)"; \
         if test $(FAIL_TEST) -eq 0; then echo "$(GROUP): All tests are succeded."; fi

clean:
	@for target in $(TESTS); do $(MAKE) clean -C $$target; done
	@rm -f $(GROUP_LOG_FILE)

cleanall:
	@for target in $(TESTS); do $(MAKE) cleanall -C $$target; done
	@rm -f $(GROUP_LOG_FILE)
