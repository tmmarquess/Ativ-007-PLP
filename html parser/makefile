parser: parser.l
	flex -o parser.l.c parser.l
	gcc -o parser parser.l.c -ll -lm 

clean:
	rm -f *.tab.c *.l.c *.h parser

