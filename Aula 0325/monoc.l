%{
#include <stdio.h>
#include <stdlib.h>

void print_token(const char *token_name, const char *token_value) {
    printf("(%s, \"%s\")\n", token_name, token_value);
}
%}

%option yylineno

%%
"//".*                     ; /* Ignora comentários de linha */ 
[ \t\n]                    ; /* Ignora espaços em branco e tabulações */

"var"                      { print_token("VARDEF", yytext); }
"if"                       { print_token("IF", yytext); }
"else"                     { print_token("ELSE", yytext); }
"while"                    { print_token("WHILE", yytext); }
"break"                    { print_token("BREAK", yytext); }
"and"                      { print_token("AND", yytext); }
"or"                       { print_token("OR", yytext); }
"not"                      { print_token("NOT", yytext); }
"print"                    { print_token("PRINT", yytext); }
"read"                     { print_token("READ", yytext); }

[0-9]+                     { print_token("INTLITERAL", yytext); }

[A-Za-z][A-Za-z0-9_]*       { print_token("IDENT", yytext); }

"=="                       { print_token("EQUAL", yytext); }
"!="                       { print_token("NOTEQ", yytext); }
"<="                       { print_token("LE", yytext); }
">="                       { print_token("GE", yytext); }
"<"                        { print_token("LT", yytext); }
">"                        { print_token("GT", yytext); }

"+"                        { print_token("PLUS", yytext); }
"-"                        { print_token("MINUS", yytext); }
"*"                        { print_token("TIMES", yytext); }
"/"                        { print_token("DIVIDE", yytext); }

"("                        { print_token("LPAREN", yytext); }
")"                        { print_token("RPAREN", yytext); }
"{"                        { print_token("LBRACE", yytext); }
"}"                        { print_token("RBRACE", yytext); }
";"                        { print_token("SEMICOLON", yytext); }
","                        { print_token("COMMA", yytext); }

"="                        { print_token("ATTRIB", yytext); }

.                          {
                              fprintf(stderr, "Error: '%s' is not recognized (line %d)\n", yytext, yylineno);
                              exit(1);
                           }
%%
int yywrap(){
    return 1;
}

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
    yylex();
    fclose(yyin);
    return 0;
}
