CC = gcc
CFLAGS = -g
.PHPNY: clean
hoc1: hoc.o
	$(CC) $(CFLAGS) -o $@ $^
clean:
	rm -f hoc1 hoc.tab.c *.o
	make clean -sC test
check:
	@make -sC test
