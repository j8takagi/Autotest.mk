CC = gcc

.PHONY: all check clean

all: triangle

triangle: triangle.c
	$(CC) -o triangle triangle.c

check:
	@$(MAKE) -sC test

clean:
	rm -f triangle
	$(MAKE) -sC test clean
