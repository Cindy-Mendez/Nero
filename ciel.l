%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
void yyerror (char *s);
int yylex();
%}
%%
"print"				   								{return PRINT_TOKEN;}
"exit"				   								{return EXIT_TOKEN;}
int|float											{yylval.myType = strdup(yytext); return DATA_TYPE_TOKEN;}
[a-zA-Z]*			   								{yylval.myString = strdup(yytext); return VAR_TOKEN;}
[0-9]+												{yylval.num = atoi(strdup(yytext)); return INT_TOKEN;}
[0-9]+[.][0-9]+						 				{yylval.fl = atof(strdup(yytext)); return FLOAT_TOKEN;}
[ \t\n]                								;
[-+*/=;()]           	   								{return yytext[0];}
.                      								{yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}