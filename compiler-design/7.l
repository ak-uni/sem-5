%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[a-zA-Z_][a-zA-Z_0-9]*   { return VAR; }
[0-9]+                   { yylval = atoi(yytext); return NUMBER; }
[ \t\n]  		 { }
.                        { return yytext[0]; }
%%

int yywrap() {
    return 1;
}

