%{
#include <stdio.h>
#include<stdlib.h>
%}
%token NUMBER
%left '+' '-'
%%
S:E {printf("Result: %d\n", $$,$1);}
 ;
E : E'+'T {$$=$1+$3;}
  | E'-'T {$$=$1-$3;}
  | T	{$$=$1;}
  ;
T:NUMBER	{$$=$1;}
 ;
%%
int main() {
	printf("Enter an expression: ");
	yyparse();
    return 0;
}

void yyerror(const char *s) {
	printf("Error: %s\n", s);
}

int yywrap() {
	return 1;
}
