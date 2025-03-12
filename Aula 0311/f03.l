%{
    #include <stdio.h>
%}
DIGITO          [0-9]
INTEIRO         {DIGITO}+ 
HM              {DIGITO}{2}
HORACOMPLETA    {HM}:{HM}
%%
{INTEIRO}       { printf("Inteiro: %s\n", yytext); }
{HORACOMPLETA}  { printf("Hora: %s\n", yytext); }
\n  ;
.   ;
%%
