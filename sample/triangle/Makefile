CC = gcc

.PHONY: normal bug check clean check

normal: clean
	$(CC) -o triangle triangle.c

bug: clean
	$(CC) -o triangle triangle_bug.c

check:
	$(MAKE) -C test

clean:
	rm -f triangle
