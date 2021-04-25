%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>
#include <math.h>
int currentVarCounter;
char varNames[50][50];
float varValues[50];
char varTypes[50][50];
float findValue(char* myString);
int getVarIndex(char* aVar);
float pi = 3.14159265359;
%}

/* Yacc/Tokens definitions */
%union {
			int num; 
			float fl; 
			char* myString; 
			char* myType;
		} 

%start LINE
%token PRINT_TOKEN
%token EXIT_TOKEN
%token T_AREA_TOKEN
%token R_AREA_TOKEN
%token C_AREA_TOKEN
%token C_CIRC_TOKEN
%token S_ROOT_TOKEN
%token R_VOL_TOKEN
%token S_VOL_TOKEN
%token C_VOL_TOKEN
%token SIN_TOKEN
%token COS_TOKEN
%token TAN_TOKEN
%token FORCE_TOKEN
%token VOLTAGE_TOKEN
%token <num> INT_TOKEN
%token <fl> FLOAT_TOKEN
%token <myString> VAR_TOKEN
%token <myType> DATA_TYPE_TOKEN

%left  '+' '-'
%left  '*' '/'
%left  '^'

%type <myString> ASSIGNMENT LINE
%type <fl> EXPR TERM 

%%

//GRAMMAR//
/* descriptions of expected inputs     corresponding actions (in C) */

LINE    : ASSIGNMENT ';'			{;}
		| EXIT_TOKEN ';'			{exit(EXIT_SUCCESS);}
		| PRINT_TOKEN EXPR ';'		{printf("printing %f\n", $2);}
		| LINE ASSIGNMENT ';'		{;}
		| LINE PRINT_TOKEN EXPR ';'	{printf("printing %f\n", $3);}
		| LINE EXIT_TOKEN ';'		{exit(EXIT_SUCCESS);}
        ;

ASSIGNMENT : DATA_TYPE_TOKEN VAR_TOKEN '=' EXPR          {
														    //Using the strcpy function to copy the
														    //value of VAR_TOKEN in the varNames array
															strcpy(varNames[currentVarCounter], $2);
															//Copying the value of exp into our
															//varValues array
           	                         						varValues[currentVarCounter] = $4;
           	                         						//Using the strcpy function to copy the
														    //value of DATA_TYPE in the varTypes array
           	                         						strcpy(varTypes[currentVarCounter], $1);
           	                         						//Adding one to our var counter
                                     						currentVarCounter++;
                                     					} 
           
	        | VAR_TOKEN '=' EXPR                     	{
	        												//Looks for the index where the var is stored
	           												int varIndex = getVarIndex($1);
	           												//If its found then the value of the var gets updated
			           										if(varIndex != -1)
			           										{
			           											varValues[varIndex] = $3;
			           										}
			           										//If its not found then it throws an error
			           										else
			           										{
			           											yyerror("Var hasn't been initialized!");
			           											exit(0);
			           										}
			           									}
		   ;
EXPR   	: TERM                  							{$$ = $1;}
       	| EXPR '+' EXPR          							{$$ = $1 + $3;}
       	| EXPR '-' EXPR          							{$$ = $1 - $3;}
	    | EXPR '*' EXPR          							{$$ = $1 * $3;}
	    | EXPR '/' EXPR          							{$$ = $1 / $3;} 
	    | EXPR '^' EXPR										{$$ = pow($1, $3);} 
	    | '(' EXPR ')'           							{$$ = $2;} 
	    | T_AREA_TOKEN '(' EXPR ',' EXPR ')'  				{$$ = ($3 * $5) / 2.0;}
	    | R_AREA_TOKEN '(' EXPR	',' EXPR ')'				{$$ = $3 * $5;}
	    | C_AREA_TOKEN '(' EXPR	')'							{$$ = pi * pow($3, 2.0);}
		| C_CIRC_TOKEN '(' EXPR ')'							{$$ = 2.0 * pi * $3;}
	    | S_ROOT_TOKEN '(' EXPR ')'  						{$$ = sqrt($3);}
		| R_VOL_TOKEN '(' EXPR ',' EXPR ',' EXPR ')'		{$$ = $3 * $5 * $7;}
		| S_VOL_TOKEN '(' EXPR ')'							{$$ = (4/3) * pi * pow($3, 3.0);}
		| C_VOL_TOKEN '(' EXPR ',' EXPR ')'					{$$ = pi * pow($3, 2.0) * $5;}
		| SIN_TOKEN '(' EXPR ')'							{$$ = sin($3);}
		| COS_TOKEN '(' EXPR ')'							{$$ = cos($3);}
		| TAN_TOKEN '(' EXPR ')'							{$$ = tan($3);}
		| FORCE_TOKEN '(' EXPR ',' EXPR ')'					{$$ = $3 * $5;}
		| VOLTAGE_TOKEN '(' EXPR ',' EXPR ')'				{$$ = $3 * $5;}

       	;

TERM   	: INT_TOKEN                	{$$ = (float) $1;}
		| VAR_TOKEN					{	
										float varValue = findValue($1);
								 		if(varValue == -1)
								 		{
										 	yyerror("Var doesn't exist!");
		           							exit(0);
								 		}
									 	else
									 		$$ = varValue;
									 }
	    | FLOAT_TOKEN               {$$ = $1;}						
        ;

%%                     
/* C code */

//Function to find the value of a variable
float findValue(char* aVar)
{
	int i;
	for(i=0; i<50; i++) 
	{
		if(strcmp(varNames[i], aVar) == 0)
		{
			return varValues[i];
		}
	}
	return -1;
}

//Function to get the index of where a variable is stored in the
//varNames array
int getVarIndex(char* aVar)
{
	int i;
	for(i=0; i<50; i++) 
	{
		if(strcmp(varNames[i], aVar) == 0)
		{
			return i;
		}
	}
	return -1;
}

//Main
int main (void) 
{

	currentVarCounter = 0;
	return yyparse ( );
}

void find_roots(float a, float b, float c) {
    float discriminant = b * b - 4 * a * c;
    // condition for real and different roots
    if (discriminant > 0) {
        float root1 = (-b + sqrt(discriminant)) / (2 * a);
        float root2 = (-b - sqrt(discriminant)) / (2 * a);
        printf("root1 = %.2lf and root2 = %.2lf", root1, root2);
    }
    // condition for real and equal roots
    else if (discriminant == 0) {
        float root1 = root2 = -b / (2 * a);
        printf("root1 = root2 = %.2lf;", root1);
    }
    //roots not real
    else {
        printf("Roots are not real");
    }
} 

//Function to throw errors
void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 