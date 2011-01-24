include ../Define.mk
include ../Test.mk

CC := gcc
CFLAGS := -Wall

.INTERMEDIATE: $(CMD_FILE)

CMDSRC_FILE := cmd.c
TESTTARGET_FILES := ../../sort.c      # Set test target files

$(CMD_FILE): $(CMDSRC_FILE) $(TESTTARGET_FILES)
	$(CC) $(CFLAGS) -o $@ $^ >compile.log 2>&1
