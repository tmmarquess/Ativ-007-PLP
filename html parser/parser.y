/*
AAAAAAAAAAAAAAA
*/

%{
#include "stack.c"
extern FILE* yyin;

void yyerror(char *s);
int yylex(void);
int yyparse();

Stack *tags;
%}

%union{
    char *str_val;
	double double_val;
};

%token <str_val> OPENTAG CLOSETAG BLANKSPACE STRING

%type <str_val> STATEMENT EXPRESSION

%%

STATEMENT:
	OPENTAG EXPRESSION {add_value(&tags, $1);}
	;

EXPRESSION:
	OPENTAG EXPRESSION CLOSETAG EXPRESSION{add_value(&tags, $1); check_tag_match(&tags, $3);}
	|	OPENTAG CLOSETAG {add_value(&tags, $1); check_tag_match(&tags, $2);}
	|	STRING {$$ = $1;}
	|
	;

%%

void yyerror(char *s)
{
	printf("Error: %s\n", s);
	exit(1);
}

int main(int argc, char *argv[])
{
	tags = NULL;
	if (argc == 1)
    {
		yyparse();
    }

	if (argc == 2)
	{
    	yyin = fopen(argv[1], "r");
		yyparse();
    }
	finish_code(&tags);
	return 0;
}
