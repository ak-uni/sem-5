%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]* { yylval.strval = strdup(yytext); return VAR; }
"+"                   { return '+'; }
"-"                   { return '-'; }
"*"                   { return '*'; }
"/"                   { return '/'; }
"("                   { return '('; }
")"                   { return ')'; }
[ \t\n]              ; /* Skip whitespace */
.                    { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
