%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(const char *s);
%}

%union {
    char* strval;
}

%token <strval> VAR

/* Define operator precedence */
%left '+' '-'
%left '*' '/'
%left '(' ')'

%%
S : E 
  ;

E : E '+' E { printf("+ "); }
  | E '-' E { printf("- "); }
  | E '*' E { printf("* "); }
  | E '/' E { printf("/ "); }
  | '(' E ')'
  | F
  ;

F : VAR { printf("%s ", $1); }
  ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
