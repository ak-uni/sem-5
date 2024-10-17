%{
#include "y.tab.h"
%}

%%
while				return WHILE;
for				return FOR;
[a-zA-Z_]+			return ID;
[0-9]+				return NUM;
\=\=|\>\=|\<\=|\>|\!\=|\<	return REL;
=				return ASSIGN;
\+|\-|\*|\/			return BIN_OP;
\+\+|\-\-			return UN_OP;
[ \t\r\n] 			{}
.				return yytext[0];
%%

int yywrap() {
	return 1;
}
