%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <string.h>
#include <math.h>
int currentVarCounter;
char varNames[50][50];
float varValues[50];
char varTypes[50][50];

int getVarIndex(char* aVar);
float findRoots(float a, float b, float c);
void helptext();
char * getAllButFirstAndLast(char *input);
float pi = 3.14159265359;
%}

/* Yacc/Tokens definitions */
//La union se utiliza para asignarle tipos a los tokens que se llaman con $ en la gramatica
//Todas las variables que se accesan con $, necesitan un tipo, o C no va a
//saber que hacer
%union {
			//digits: 0, 3, 5, 7....
			int num; 
			//decimales: 3.23, 1.25, 5.2
			float fl; 
			//var names: x, y, variable...
			char* myString; 
			//varTypes: int o float
			char* myType;
			//stringsToPrint: "hello world", "my name is Cindy"...
			char* stringText;
		} 

%start STATEMENT //donde comienza la gramatica
%token PRINT_TOKEN
%token EXIT_TOKEN
%token HELP_TOKEN
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
%token <stringText> STRING_TOKEN //string type
%token <num> INT_TOKEN //int type
%token <fl> FLOAT_TOKEN //float type
%token <myString> VAR_TOKEN //string type
%token <myType> DATA_TYPE_TOKEN //string type

//Asignacion de presedencia, va de menor a mayor presedencia.
//Pueden haber muchas expresiones en una misma expresion, por esto necesitamos un orden de presedencia.
%left  '+' '-'
%left  '*' '/'
%left  '^'

//Tipos de non-terminal Tokens.
//El tipo del statement y el assignment no importa, pero es importante
//definir que tanto la expresion y el termino es float para
//asegurar que siempre me devuelva un float.
%type <myString> STATEMENT ASSIGNMENT 
%type <fl> EXPR TERM 

%%

//GRAMMAR//

STATEMENT    	: ASSIGNMENT ';'								{;}
				| EXIT_TOKEN ';'								{exit(0);}
				| HELP_TOKEN ';'								{helptext();}
				| PRINT_TOKEN EXPR ';'							{printf("%.2f\n", $2);}
				| PRINT_TOKEN STRING_TOKEN ';'					{printf("%s\n", getAllButFirstAndLast($2));}
				| EXPR ';'										{	//Con esto el programa es mas simple y puedo escribir sin(5) 
																	//en el cmd y obtener la respuesta sin tener que escribir print 
																	printf("%.2f\n", $1);
																} 
				| STATEMENT ASSIGNMENT ';'						{;} //Se usa recursion de statement para poder llamar los statements mas de una vez
				| STATEMENT EXIT_TOKEN ';'						{exit(0);}
				| STATEMENT HELP_TOKEN ';'						{helptext();}
				| STATEMENT PRINT_TOKEN EXPR ';'				{printf("%.2f\n", $3);}
				| STATEMENT PRINT_TOKEN STRING_TOKEN ';'		{printf("%s\n", $3);}
				| STATEMENT EXPR ';' 							{printf("%.2f\n", $2);}
		        ;

ASSIGNMENT : DATA_TYPE_TOKEN VAR_TOKEN '=' EXPR          {
															int varIndex = getVarIndex($2);
															if(varIndex == -1)
															{
																//Uso la funcion strcpy para copiar el
																//valor de VAR_TOKEN en el arreglo varNames.
																strcpy(varNames[currentVarCounter], $2);
																//Copio el valor de la expresion en el arreglo varValues
	           	                         						varValues[currentVarCounter] = $4;
																//Uso la funcion strcpy para copiar el
																//valor de DATA_TYPE en el arreglo varTypes
	           	                         						strcpy(varTypes[currentVarCounter], $1);
	           	                         						//Le anado 1 al var counter
	                                     						currentVarCounter++;
																//Ex. DATA_TYPE_TOKEN = int, VAR_TOKEN = x, EXPR = 5
															}
															else
															{
																//Si la variable que el usuario entro ya estaba
																//definida me da error
																yyerror("Var already exists!");
			           											exit(0);
															}												    
                                     					} 
           
	        | VAR_TOKEN '=' EXPR                     	{
	        												//Busca el indice en donde la variable esta almacenada
	           												int varIndex = getVarIndex($1);
	           												//Si no lo encuentra me da un error
			           										if(varIndex == -1)
			           										{
			           											yyerror("Var hasn't been initialized!");
			           											exit(0);
			           										}
															//Si lo encuentra entonces el valor de la variable se reasigna
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

TERM   	: INT_TOKEN                	{$$ = (float) $1;} //Para no tener que trabajar con mas de un tipo
		| VAR_TOKEN					{	
										//Busca el indice de la variable y si existe me da
										//el valor de la variable en la expresion
										//Si la variable no existe me da error
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

//Funcion para obtener el indice en donde la variable es almacenada en el arreglo varNames
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
//Funcion para calcular la formula cuadratica
float findRoots(float a, float b, float c) {
	float rootOne, rootTwo;
    float discriminant = b * b - 4 * a * c;
    // Condicion para raices reales y diferentes
    if (discriminant > 0) {
        float rootOne = (-b + sqrt(discriminant)) / (2 * a);
        float rootTwo = (-b - sqrt(discriminant)) / (2 * a);
        printf("First Root = %.2f and Second Root = %.2f\n", rootOne, rootTwo);
        printf("Amount of real roots: ");
		return 2;
    }
    // Condicion para raices reales y iguales
    else if (discriminant == 0) {
        float rootOne = -b / (2 * a);
        printf("First Root = Second Root = %.2f\n", rootOne);
        printf("Amount of real roots: ");
		return 1;
    }
    // COndicion cuando raices no son reales
    else {
        printf("Roots are not real!\n");
        printf("Amount of real roots: ");
		return 0;
    }
} 

//Funcion para imprimir errores
void yyerror (char *s) 
{
	fprintf (stderr, "%s\n", s);
} 

//Funcion para imprimir todo lo que esta en el help file
void helptext()
{
    FILE *fptr;
    char text;
  
    // Open file
    fptr = fopen("help.txt", "r");
    if (fptr == NULL)
    {
        printf("Cannot open file \n");
        exit(0);
    }
  
    // Read contents from file
    text = fgetc(fptr);
    while (text != EOF)
    {
        printf ("%c", text);
        text = fgetc(fptr);
    }
  
    fclose(fptr);
}

//Funcion para remover el primer y el ultimo caracter
//de un string. Lo usamos para remover las doble
//comillas de un string.
char * getAllButFirstAndLast(char *input)
{
  int len = strlen(input); 
  if(len > 0)
    input++;//Go past the first char
  if(len > 1)
    input[len - 2] = '\0';//Replace the last char with a null termination
  return input;
}

//Main
int main (void) 
{
	//inicializa el counter que se usa para escribir las 
	//variables en el programa
	currentVarCounter = 0;
	
	return yyparse ( );
}
