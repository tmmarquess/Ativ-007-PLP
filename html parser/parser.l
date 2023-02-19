%{
    /*Exemplo de uso do flex*/
%}

OPENTAG     <[^<\/]+>
CLOSETAG    <\/[^<]+>
STRING      [^<>"\n"]+

%%
{OPENTAG}   {printf("Voce abriu uma tag: \"%s\"\n", yytext);}
{CLOSETAG}  {printf("Voce fechou uma tag: \"%s\"\n", yytext);}
[[:space:]] ;
{STRING}    {printf("String dentro da Tag \"%s\"\n", yytext);}
.           {printf("Nao reconhecido: \"%s\"\n", yytext);}
%%
int main(int argc, char *argv[])
{
    if(argc < 2)
    {
        printf ("Missing input file\n");
        exit(-1);
    }
    yyin = fopen(argv[1], "r" );
    yylex();
}