%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char* s);

int temp = 0;
%}

%token NUMBER
%token VAR

%%
expr : expr '+' term { printf("t%d = t%d + t%d\n", temp, $1, $3); $$ = temp++; }
     | expr '-' term { printf("t%d = t%d - t%d\n", temp, $1, $3); $$ = temp++;  }
     | term
     ;

term : term '*' factor { printf("t%d = t%d * t%d\n", temp, $1, $3); $$ = temp++; }
     | term '/' factor { printf("t%d = t%d / t%d\n", temp, $1, $3); $$ = temp++; }
     | factor
     ;

factor : '(' expr ')' { $$ = $2; }
       | NUMBER { printf("t%d = %d\n", temp, $1); $$ = temp++; }
       ;

%%

int main() {
    if (yyparse() == 0) {
        printf("Parsing completed successfully!\n");
    }
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
