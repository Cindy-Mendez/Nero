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

int getVarIndex(char* aVar);
float findRoots(float a, float b, float c);
float pi = 3.14159265359;
%}

/* Yacc/Tokens definitions */
%union {
			int num; 
			float fl; 
			char* myString; 
			char* myType;
			char* stringText;
		} 

%start STATEMENT
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
%token ROOTS_TOKEN
%token FORCE_TOKEN
%token VOLTAGE_TOKEN
%token <stringText> STRING_TOKEN
%token <num> INT_TOKEN
%token <fl> FLOAT_TOKEN
%token <myString> VAR_TOKEN
%token <myType> DATA_TYPE_TOKEN

//Assign precedence, from lowest precedence to highest
%left  '+' '-'
%left  '*' '/'
%left  '^'

//Types of non-terminal Tokens
%type <myString> ASSIGNMENT STATEMENT
%type <fl> EXPR TERM 

%%

//GRAMMAR//
/* descriptions of expected inputs     corresponding actions (in C) */

STATEMENT    	: ASSIGNMENT ';'								{;}
				| EXIT_TOKEN ';'								{exit(EXIT_SUCCESS);}
				| PRINT_TOKEN EXPR ';'							{printf("%.2f\n", $2);}
				| PRINT_TOKEN STRING_TOKEN ';'					{printf("%s\n", $2);}
				| EXPR ';'										{printf("%.2f\n", $1);}
				| STATEMENT ASSIGNMENT ';'						{;}
				| STATEMENT EXIT_TOKEN ';'						{exit(EXIT_SUCCESS);}
				| STATEMENT PRINT_TOKEN EXPR ';'				{printf("%.2f\n", $3);}
				| STATEMENT PRINT_TOKEN STRING_TOKEN ';'		{printf("%s\n", $3);}
				| STATEMENT EXPR ';' 							{printf("%.2f\n", $2);}
		        ;

ASSIGNMENT : DATA_TYPE_TOKEN VAR_TOKEN '=' EXPR          {
															int varIndex = getVarIndex($2);
															if(varIndex == -1)
															{
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
															else
															{
																yyerror("Var already exists!");
			           											exit(0);
															}												    
                                     					} 
           
	        | VAR_TOKEN '=' EXPR                     	{
	        												//Looks for the index where the var is stored
	           												int varIndex = getVarIndex($1);
	           												//If its not found then it throws an error
			           										if(varIndex == -1)
			           										{
			           											yyerror("Var hasn't been initialized!");
			           											exit(0);
			           										}
			           										//If its found then the value of the var gets updated
			           										else
			           										{
			           											varValues[varIndex] = $3;
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
		| S_VOL_TOKEN '(' EXPR ')'							{$$ = (4.0/3.0) * pi * pow($3, 3.0);}
		| C_VOL_TOKEN '(' EXPR ',' EXPR ')'					{$$ = pi * pow($3, 2.0) * $5;}
		| SIN_TOKEN '(' EXPR ')'							{$$ = sin($3);}
		| COS_TOKEN '(' EXPR ')'							{$$ = cos($3);}
		| TAN_TOKEN '(' EXPR ')'							{$$ = tan($3);}
		| ROOTS_TOKEN '(' EXPR ',' EXPR ',' EXPR ')'		{$$ = findRoots($3, $5, $7);}
		| FORCE_TOKEN '(' EXPR ',' EXPR ')'					{$$ = $3 * $5;}
		| VOLTAGE_TOKEN '(' EXPR ',' EXPR ')'				{$$ = $3 * $5;}

       	;

TERM   	: INT_TOKEN                	{$$ = (float) $1;}
		| VAR_TOKEN					{	
										int varIndex = getVarIndex($1);
								 		if(varIndex == -1)
								 		{
										 	yyerror("Var doesn't exist!");
		           							exit(0);
								 		}
									 	else
									 		$$ = varValues[varIndex];
									 }
	    | FLOAT_TOKEN               {$$ = $1;}						
        ;

%%                     
/* C code */

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
//Function to calculate the quadratic roots
float findRoots(float a, float b, float c) {
	float rootOne, rootTwo;
    float discriminant = b * b - 4 * a * c;
    // condition for real and different roots
    if (discriminant > 0) {
        float rootOne = (-b + sqrt(discriminant)) / (2 * a);
        float rootTwo = (-b - sqrt(discriminant)) / (2 * a);
        printf("First Root = %.2f and Second Root = %.2f\n", rootOne, rootTwo);
        printf("Amount of roots: ");
		return 2;
    }
    // condition for real and equal roots
    else if (discriminant == 0) {
        float rootOne = -b / (2 * a);
        printf("First Root = Second Root = %.2f\n", rootOne);
        ("Amount of roots: ");
		return 1;
    }
    //roots are not real
    else {
        printf("Roots are not real!\n");
        ("Amount of roots: ");
		return 0;
    }
} 
//Main
int main (void) 
{
	currentVarCounter = 0;
	return yyparse ( );
}

//Function to throw errors
void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 