parser: parser.y parser.l
	bison -d parser.y
	flex -o parser.l.c parser.l
	gcc -o parser parser.l.c -ll -lm 

clean:
	rm -f *.tab.c *.l.c *.h parser

