/*
	Calculadora v.4 - Lê de arquivos ou linha de comando
	Jucimar Jr
*/

%{
#define YYSTYPE char *
#include "calc.tab.h" 
#include <stdlib.h>

void yyerror(char *s); 
%}

%%

[0-9]+("."[0-9]+)? 		{ yylval = yytext; return NUMBER; }
[\n]					{ return EOL; }
[+]						{ return PLUS; }
[-]						{ return MINUS; }
[/]						{ return DIVIDE; }
[*]						{ return TIMES; }
[(]						{ return P_LEFT;}
[)]						{ return P_RIGHT;}
[%]						{ return MOD; }
(\*\*)					{ return POW; }
\"						{ return QUOTE; }
("print_str")			{ return PRINT; }
[[:space:]]				;
("show")				{ return SHOW; }
[a-zA-Z][a-zA-Z0-9]+	{ yylval =  strdup(yytext); return identifier; }
([a-zA-Z0-9])
[=]						{ return attribuition; }
.						{ yyerror("Undefined token\n"); }

%%

int yywrap()
{
	return 1;
}

