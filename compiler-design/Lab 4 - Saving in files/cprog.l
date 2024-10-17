%{
#include<stdio.h>
#include<string.h>

FILE *fptr, *preprocessor, *keywords, *identifiers, *operators, *literals, *special;

void write_to_file(int, char *);
%}

%%
#.+ 			{write_to_file(1, yytext);}
int|float|char|return 	{write_to_file(2, yytext);}
[a-zA-Z0-9]+\( 	{yytext[yyleng - 1] = '\0'; write_to_file(3, yytext);}
\+|\-|\*|\/|=|% 	{write_to_file(4, yytext);}
\".*\" 		{write_to_file(5, yytext);}
\'.\' 			{write_to_file(5, yytext);}
; 			{write_to_file(6, yytext);}
\{ 			{write_to_file(6, yytext);}
\} 			{write_to_file(6, yytext);}
[0-9]+ 		{write_to_file(5, yytext);}
[0-9]+\.[0-9]* 	{write_to_file(5, yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {write_to_file(3, yytext);}
. 			{}
%%

void write_to_file(int type, char *text) {
	switch (type) {
		case 1:
			fptr = preprocessor;
			break;
		case 2:
			fptr = keywords;
			break;
		case 3:
			fptr = identifiers;
			break;
		case 4:
			fptr = operators;
			break;
		case 5:
			fptr = literals;
			break;
		case 6:
			fptr = special;
			break;
		default:
			printf("Ignoring token %s\n", text);
			break;
	}
	fputs(text, fptr);
	fputs("\n", fptr);
}

int main() {
	preprocessor = fopen("preprocessor_directive.tk", "w");
	keywords = fopen("keywords.tk", "w");
	identifiers = fopen("identifiers.tk", "w");
	operators = fopen("operators.tk", "w");
	literals = fptr = fopen("literals.tk", "w");
	special = fopen("special.tk", "w");
	yylex();
	return 0;
}

int yywrap() {
	fclose(preprocessor);
	fclose(keywords);
	fclose(identifiers);
	fclose(operators);
	fclose(literals);
	fclose(special);
	return 1;
}
