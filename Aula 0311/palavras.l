%{
    #include <stdio.h>
%}
%option yylineno

%%

[a-zA-ZÀ-ÿ]+    {printf("%d: %s\n", yylineno, yytext); }
\n      ;
.       ;

%%

int yywrap(){
    return 1;
}

int main(){
    printf("Iniciando análise léxica\n");
    yylex();
    printf("Fim da análise léxica\n");
}