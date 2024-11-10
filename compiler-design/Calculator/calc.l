%{
#include "y.tab.h"
#include <stdlib.h>    
%}

%%
[0-9]+ {
    yylval.intVal = atoi(yytext);
    return INT;
}

[0-9]+\.[0-9]* {
    yylval.floatVal = atof(yytext);
    return FLOAT;
}

[ \t\n] {}

. {return yytext[0];}
%%

int yywrap() {
    return 1;
}