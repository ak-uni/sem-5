%{
#include <stdio.h>
#include <ctype.h>
%}

%%
[0-9]+\.[0-9]{4} {
	printf("Pattern 1: %s\n", yytext);
}

.{6,10} {
	int upper = 0, special = 0, digit = 0;
	
	for (int i=0; i<yyleng; i++) {
		if isupper(yytext[i]) {
			upper = 1;
		} else if (isdigit(yytext[i])) {
			digit = 1;
		}else if (!isalpha(yytext[i]) && !isdigit(yytext[i])) {
			special = 1;
		}
	}
	
	if (yyleng == 6 && upper && special && !digit)
		printf("Pattern 2: %s\n", yytext);
	
	if (upper && special && digit)
		printf("Pattern 3: %s\n", yytext);
}

while.*\: {
	printf("While loop: %s", yytext);
}

. {}

%%
