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
"calc_tri_area"										{return T_AREA_TOKEN;}
"calc_rect_area"									{return R_AREA_TOKEN;}
"calc_circ_area"									{return C_AREA_TOKEN;}
"calc_circ_circum"                                  {return C_CIRC_TOKEN;}
"calc_vol_rect"										{return R_VOL_TOKEN;}
"calc_vol_sphre"                                    {return S_VOL_TOKEN;}
"calc_vol_cyl"                                      {return C_VOL_TOKEN;}
"square_root"										{return S_ROOT_TOKEN;}
"sin"                                               {return SIN_TOKEN;}
"cos"                                               {return COS_TOKEN;}
"tan"                                               {return TAN_TOKEN;}
"help"												{return HELP_TOKEN;}
"find_roots"                                        {return ROOTS_TOKEN;}
"calc_force"                                        {return FORCE_TOKEN;}
"calc_voltage"                                      {return VOLTAGE_TOKEN;}
int|float											{yylval.myType = strdup(yytext); return DATA_TYPE_TOKEN;}
[a-zA-Z]*			   								{yylval.myString = strdup(yytext); return VAR_TOKEN;}
-?[0-9]+												{yylval.num = atoi(strdup(yytext)); return INT_TOKEN;}
-?[0-9]+[.][0-9]+						 				{yylval.fl = atof(strdup(yytext)); return FLOAT_TOKEN;}
\"([^\\\"]|\\.)*\"									{yylval.stringText = strdup(yytext); return STRING_TOKEN;}
[ \t\n]                								;
[-+*/=;(),^]           	   							{return yytext[0];}
.                      								{yyerror ("unexpected character");}

%%
//Function yywrap is called by lex when input is exhausted. 
//When the end of the file is reached the return value of yywrap() 
//is checked. If it is non-zero, scanning terminates 
//and if it is 0 scanning continues with next input file.
int yywrap (void) 
{
	return 1;
}




