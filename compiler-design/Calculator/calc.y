%{
#include <stdio.h>

extern int yylex();
void yyerror(const char *s); 
%}

%union {
    int intVal;
    float floatVal;
}

%token <intVal> INT
%token <floatVal> FLOAT

%type <floatVal> S E T F

%%
S : E { printf("Result: %f", $1); }
  ;

E : E '+' T {$$ = $1 + $3;}
  | T {$$ = $1;}
  ;

T : T '*' F {$$ = $1 * $3;}
  | F {$$ = $1;}
  ;

F : INT {$$ = $1;}
  | FLOAT {$$ = $1;}
  ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s", s);
}