%{
#include <stdio.h>

extern int yylex();
void yyerror(const char *s);
%}

%token ID NUM WHILE FOR REL ASSIGN BIN_OP UN_OP IF ELSE

%%
S     : for {}
      | while {}
      | if {}
      ;
for   : FOR '(' var ASSIGN NUM ';' cond ';' var UN_OP ';' ')' stmt { printf("FOR"); }
      ;
while : WHILE '(' cond ')' stmt 	{ printf("WHILE "); }
      ;
if    : IF '(' cond ')' stmt 		{ printf("IF "); }
      | IF '(' cond ')' stmt ELSE stmt 	{ printf("IF-ELSE "); }
      ;
cond  : var REL var			{ printf("COND "); }
      | var REL NUM			{ printf("COND "); }
      | NUM REL var			{ printf("COND "); }
      ;
stmt  : var ASSIGN var			{ printf("ASSIGN "); }
      | var BIN_OP var 			{ printf("BIN_OP "); }
      | var UN_OP			{ printf("UN_OP "); }
      | if				{ printf("IF "); }
      | for 				{ printf("FOR "); }
      | while				{ printf("WHILE "); }
      ;
var   : ID				{ printf("ID "); }
      ;
%%

int main() {
	yyparse();
	return 0;
}

void yyerror(const char *s) {
	printf("Error: %s", s);
}
