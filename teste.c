#include <stdio.h>
#include <string.h>

int main()
{

    char *teste;
    teste = "AAAAAAAAAAAAAAa";
    char batata[(int)strlen(teste)];
    strcpy(batata, teste);
    printf("%s\n", batata);
}