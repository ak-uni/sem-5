%{
#include "y.tab.h"
%}

%%

if      return IF;
else    return ELSE;
[a-zA-Z_][a-zA-Z0-9_]*  return ID;
\<|\>|\<\=|\>\=|\=\=|\!\=  return REL;
[ \t\r\n]                 ;
.       return yytext[0];

%%

int yywrap() {
    return 1;
}
