%{
#include <stdio.h>
%}

%%
\n { printf("Nova linha\n"); }
. ;

%%

int yywrap(){ return 1; }

int main(int argc, char **argv){
    if(argc != 2){
        printf("Uso: %s <arquivo>\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if(yyin == NULL){
        printf("Erro ao abrir o arquivo %s\n", argv[1]);
        return 1;
    }
    yylex();
    return 0;
}
