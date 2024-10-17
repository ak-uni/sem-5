%{
#include <stdio.h>
%}

%%
[1-9][0-9]{9} {printf("%s is a valid mobile number.", yytext);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
