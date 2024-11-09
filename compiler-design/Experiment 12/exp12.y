%{
#include <stdio.h>
#include <stdlib.h>

int reg = 1;
void yyerror(char *s);
int yylex(void);
%}

%token NUMBER ID ASSIGN PLUS MINUS MULTIPLY DIVIDE

%%
program:
        program statement '\n'
        |
        ;

statement:
        ID ASSIGN expr    { 
            printf("Mov R%d, %c\n", reg, $3);
        }
        ;

expr:
        ID PLUS ID       { 
            printf("Mov %c, R1\n", $1);
            printf("Mov %c, R2\n", $3);
            printf("Add R1, R2\n");
            $$ = '1';
        }
        | ID MINUS ID    { 
            printf("Mov %c, R1\n", $1);
            printf("Mov %c, R2\n", $3);
            printf("Sub R1, R2\n");
            $$ = '1';
        }
        | ID MULTIPLY ID { 
            printf("Mov %c, R1\n", $1);
            printf("Mov %c, R2\n", $3);
            printf("Mul R1, R2\n");
            $$ = '1';
        }
        | ID DIVIDE ID   { 
            printf("Mov %c, R1\n", $1);
            printf("Mov %c, R2\n", $3);
            printf("Div R1, R2\n");
            $$ = '1';
        }
        | ID            { $$ = $1; }
        | NUMBER        { $$ = $1 + '0'; }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
