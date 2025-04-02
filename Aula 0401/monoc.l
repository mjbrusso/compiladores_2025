%{
#include <stdio.h>
#include <stdlib.h>
#include "monoc.tab.h"

%}

%option yylineno

%%
"//".*                     ; /* Ignora comentários de linha */ 
[ \t\n]                    ; /* Ignora espaços em branco e tabulações */
[0-9]+                     { yylval = atoi(yytext); return INTLITERAL; }
";"                        { return SEMICOLON; }
"print"                    { return PRINT; }
"("                        { return LPAREN; }
")"                        { return RPAREN; }
"+"                        { return PLUS; }
"-"                        { return MINUS; }
"*"                        { return TIMES; }
"/"                        { return DIVIDE; }

 /*
"var"                      { return VARDEF; }
"if"                       { return IF; }
"else"                     { return ELSE; }
"while"                    { return WHILE; }
"break"                    { return BREAK; }
"and"                      { return AND; }
"or"                       { return OR; }
"not"                      { return NOT; }
"read"                     { return READ; }
[A-Za-z][A-Za-z0-9_]*       { return IDENT; }
"=="                       { return EQUAL; }
"!="                       { return NOTEQ; }
"<="                       { return LE; }
">="                       { return GE; }
"<"                        { return LT; }
">"                        { return GT; }
"{"                        { return LBRACE; }
"}"                        { return RBRACE; }
","                        { return COMMA; }
"="                        { return ATTRIB; }
 */
.                          {
                              fprintf(stderr, "Error: '%s' is not recognized (line %d)\n", yytext, yylineno);
                              exit(1);
                           }
%%
