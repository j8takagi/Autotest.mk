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

include Define.beta.mk

.PHONY: check create set checkeach report clean cleanall

check: checkeach report

create:
ifndef TEST
	@$(ECHO) "no test created. set TEST."
else
	@$(MKDIR) $(TEST)
	@for ifile in $(DEF_FILE) $(TEST_MAKEFILE); do $(ECHO) "include ../$$ifile" >>$(TEST)/Makefile; done
endif

set:
	@for target in $(TESTS); do $(MAKE) set -C $$target; done

checkeach:
	@$(RM) $(GROUP_LOG_FILE)
	@for target in $(TESTS); do $(MAKE) check -C $$target; done

$(GROUP_LOG_FILE):
	@for target in $(TESTS); do ($(ECHO) <$$target/$(LOG_FILE) && $(CAT) <$$target/$(LOG_FILE)) >>$@ || $(ECHO) $$target ": no log." >>$@; done

report: $(GROUP_LOG_FILE)
	@$(ECHO) "$(GROUP): $(SUCCESS_TEST) / $(ALL_TEST) tests passed. Details in `pwd`/$(GROUP_LOG_FILE)"; \
         if test $(FAIL_TEST) -eq 0; then $(ECHO) "$(GROUP): All tests are succeded."; fi

time: timeeach $(GROUP_TIME_FILE)
	@$(CAT) $(GROUP_TIME_FILE)

$(GROUP_TIME_FILE):
	@for target in $(TESTS); do ($(ECHO)<$$target/$(LOG_FILE) && $(CAT) <$$target/$(TIME_FILE)) >>$@ || $(ECHO) $$target ": no time." >>$@; done

timeeach:
	@for target in $(TESTS); do $(MAKE) time -C $$target; done

clean:
	@for target in $(TESTS); do $(MAKE) clean -C $$target; done
	@$(RM) $(GROUP_LOG_FILE)
