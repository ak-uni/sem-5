%{
#include <stdio.h>
%}

%%
[0-9]+ {printf("%s is an integer", yytext);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
