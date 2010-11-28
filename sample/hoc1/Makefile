CC = gcc

CFLAGS = -g -lm

.INTERMEDIATE: hoc.o

hoc1: hoc.o
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f hoc1 *.o

check:
	$(MAKE) -sC test
