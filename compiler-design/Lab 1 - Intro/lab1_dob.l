%{
#include <stdio.h>
%}

%%
[0-3]*[0-9]\/[0-1][0-2]\/(19[0-9][0-9]|20[0-2][0-4]) {printf("%s is a valid DOB.", yytext);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
