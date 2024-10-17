%{
#include <stdio.h>
%}

%%
[0-9]+.[0-9]+ {printf("%s is a float", yytext);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
