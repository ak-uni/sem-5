%{
#include "y.tab.h"
%}

%%
[a-zA-Z_][a-zA-Z_0-9]*   return VAR;
[0-9]+                   return NUMBER;
.                        return yytext[0];
%%

int yywrap() {
    return 1;
}
