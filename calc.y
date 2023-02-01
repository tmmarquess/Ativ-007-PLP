/*
	Calculadora v.4 - Lê de arquivos ou linha de comando
	Jucimar Jr
*/

%{
#include <stdio.h>
#include "hash_table.c"
#include <math.h>
extern FILE* yyin;

void yyerror(char *s);
int yylex(void);
int yyparse();

hash_table variables;
%}

%union{
    double double_val;
    char *str_val;
};

%token EOL
%token PLUS MINUS DIVIDE TIMES MOD POW
%token SHOW attribuition QUOTE PRINT
%token P_LEFT P_RIGHT

%left PLUS MINUS
%left TIMES DIVIDE
%left MOD POW
%left P_LEFT P_RIGHT

%token <double_val> NUMBER
%token <str_val> identifier

%type <double_val> STATEMENT EXPRESSION

%%

STATEMENT:
	STATEMENT EXPRESSION EOL {$$ = $2; printf("Resultado: %f\n", $2);}
	| STATEMENT identifier attribuition EXPRESSION EOL {printf("atribuicao\n");}
	| STATEMENT SHOW EOL {print_table(variables);}
	| STATEMENT PRINT P_LEFT QUOTE identifier QUOTE P_RIGHT EOL {printf("%s\n",$5);}
	|
	;

EXPRESSION:
	NUMBER {$$ = $1;}
	|	EXPRESSION PLUS EXPRESSION {$$ = $1 + $3;}
	|	EXPRESSION MINUS EXPRESSION {$$ = $1 - $3;}
	|	EXPRESSION TIMES EXPRESSION {$$ = $1 * $3;}
	|	EXPRESSION DIVIDE EXPRESSION {$$ = $1 / $3;}
	|	EXPRESSION MOD EXPRESSION {$$ = (int) $1 % (int) $3;}
	|	EXPRESSION POW EXPRESSION {$$ = pow($1, $3);}
	|	P_LEFT EXPRESSION P_RIGHT {$$ = $2;}
	;


%%

void yyerror(char *s)
{
	printf("Error: %s\n", s);
	yyparse();
}

int main(int argc, char *argv[])
{
	if (argc == 1)
    {
		yyparse();
    }

	if (argc == 2)
	{
    	yyin = fopen(argv[1], "r");
		yyparse();
    }

	return 0;
}
