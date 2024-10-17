%{
#include<stdio.h>
%}

%%
#.+ {printf("%s is preprocessor directive\n", yytext);}
int|float|char|return {printf("%s is a keyword\n", yytext);}
[a-zA-Z0-9]+\( {printf("%s) is a function\n", yytext);}
\+|\-|\*|\/|=|% {printf("%s is an operator\n", yytext);}
\".*\" {printf("%s is a string\n", yytext);}
\'.\' {printf("%s is a character\n", yytext);}
; {printf("%s is line terminator\n", yytext);}
\{ {printf("%s - block begins\n", yytext);}
\} {printf("%s - block ends\n", yytext);}
[0-9]+ {printf("%s is an integer\n", yytext);}
[0-9]+\.[0-9]* {printf("%s is a float\n", yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {printf("%s is an identifier\n", yytext);}
. {}
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}
