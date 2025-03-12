%{
    #include <stdio.h>
%}

%%
[0-9]+              { printf("Inteiro: %s\n", yytext); }
[0-9]{2}:[0-9]{2}   { printf("Hora: %s\n", yytext); }
\n  ;
.   ;
%%
