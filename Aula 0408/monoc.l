%{
#include "symtab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "monoc.tab.h"

extern Symtab *ts; 
%}

%option yylineno

%%
"//".*                     ; /* Ignora comentários de linha */ 
[ \t\n]                    ; /* Ignora espaços em branco e tabulações */
[0-9]+                     { yylval.ival = atoi(yytext); return INTLITERAL; }
";"                        { return SEMICOLON; }
"print"                    { return PRINT; }
"("                        { return LPAREN; }
")"                        { return RPAREN; }
"+"                        { return PLUS; }
"-"                        { return MINUS; }
"*"                        { return TIMES; }
"/"                        { return DIVIDE; }
"var"                      { return VARDEF; }
"read"                     { return READ; }
[A-Za-z][A-Za-z0-9_]*      { yylval.sval = symtab_insert(ts, yytext);
                             return IDENT; }
"="                        { return ATTRIB; }

 /*
"if"                       { return IF; }
"else"                     { return ELSE; }
"while"                    { return WHILE; }
"break"                    { return BREAK; }
"and"                      { return AND; }
"or"                       { return OR; }
"not"                      { return NOT; }


"=="                       { return EQUAL; }
"!="                       { return NOTEQ; }
"<="                       { return LE; }
">="                       { return GE; }
"<"                        { return LT; }
">"                        { return GT; }
"{"                        { return LBRACE; }
"}"                        { return RBRACE; }
","                        { return COMMA; }

 */
.                          {
                              fprintf(stderr, "Error: '%s' is not recognized (line %d)\n", yytext, yylineno);
                              exit(1);
                           }
%%
