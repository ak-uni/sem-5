%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = *yytext; return ID; }
"="         { return ASSIGN; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
[ \t\n]     ;
.           { return yytext[0]; }
%%

int yywrap(void) {
    return 1;
}
