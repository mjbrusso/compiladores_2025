%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
extern int yylineno;

int yylex();

void yyerror(char *msg){
    printf("%s (line %d)\n", msg, yylineno);
    exit(1);
}
%}

%token PRINT LPAREN RPAREN SEMICOLON INTLITERAL

%%

program: 
    /* empty program */
    | program cmd
    ;

cmd:
    print
    ;

print:
        PRINT LPAREN expr RPAREN SEMICOLON  { printf("%d\n", $3);}
    |   PRINT LPAREN RPAREN SEMICOLON       { printf("\n"); }
    ;

expr:
        INTLITERAL                          { $$ = $1; }
        ;
%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "%s: Error: no input file\n", argv[0]);
        exit(1);
    }
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Erro ao abrir o arquivo");
        exit(1);
    }
    yyparse();
    fclose(yyin);
    return 0;
}
