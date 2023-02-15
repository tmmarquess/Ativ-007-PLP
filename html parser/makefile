calc: calc.l
	flex -o calc.l.c calc.l
	gcc -o calc calc.l.c -ll -lm 

clean:
	rm -f *.tab.c *.l.c *.h calc

