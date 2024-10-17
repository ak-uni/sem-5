%{
#include <stdio.h>
#include <string.h>
%}

%%
12[0-7]0[0-1][0-8]0[0-9][0-9] {printf("%s is a valid regno.", *&yytext[strlen(yytext) - 4]);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
