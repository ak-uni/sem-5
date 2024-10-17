%{
#include <stdio.h>

extern int yylex();
void yyerror(const char* s);
%}

%token IF ELSE ID REL

%%

stmt : IF '(' cond ')' stmt { printf("IF "); }
     | IF '(' cond ')' stmt ELSE stmt { printf("IF-ELSE "); }
     | assign ';' { printf("ASSIGN "); }
     ;

cond : var REL var { printf("CONDITION "); }
     ;

assign : var '=' expr { printf("ASSIGN_OP "); }
       ;

expr : expr '+' term { printf("PLUS "); }
     | term
     ;

term : term '*' factor { printf("MULT "); }
     | factor
     ;

factor : '(' expr ')'
       | var
       ;

var : ID { printf("VAR "); }
    ;

%%

int main() {
    return yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\\n", s);
}
