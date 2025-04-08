%{
#include "symtab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylineno;

Symtab *ts; 

int yylex();

void yyerror(char *msg){
    printf("%s (line %d)\n", msg, yylineno);
    exit(1);
}
%}
%union{
    int ival;
    SymtabEntry *sval;
}

%token <ival> INTLITERAL 
%token <sval> IDENT
%token PRINT LPAREN RPAREN SEMICOLON 
%token PLUS MINUS TIMES DIVIDE
%token VARDEF READ ATTRIB

%type <ival> expr

%left PLUS MINUS
%left TIMES DIVIDE

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
        expr PLUS expr           { $$ = $1 + $3;}
    |   expr MINUS expr          { $$ = $1 - $3;}
    |   expr TIMES expr          { $$ = $1 * $3;}
    |   expr DIVIDE expr         { $$ = $1 / $3;} 
    |   LPAREN expr RPAREN       { $$ = $2; }   
    |   INTLITERAL               { $$ = $1; }
    |   IDENT                    { 
                                    if(!$1->defined){
                                        printf("%s not defined (line %d)\n", $1->key, yylineno);
                                        exit(1);
                                    }
                                    $$ = $1->value;
                                 }
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
    ts = symtab_create();
    yyparse();
    fclose(yyin);
    symtab_destroy(ts);
    return 0;
}
