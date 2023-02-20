%{
#include "parser.tab.c" 
#include <stdlib.h>

void yyerror(char *s); 
%}

OPENTAG             	<[^<\/]+>
CLOSETAG            	<\/[^<]+>
STRING              	[^<>]+

%%
{OPENTAG}	          	{ yylval.str_val = strdup(yytext); return OPENTAG; }
{CLOSETAG}          	{ yylval.str_val = strdup(yytext); return CLOSETAG; }
([[:space:]]+|"\n"|"") 	;
{STRING}            	{ yylval.str_val = strdup(yytext); return STRING; }
.                   	{ yyerror(yytext); }
%%
int yywrap()
{
	return 1;
}