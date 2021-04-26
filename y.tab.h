/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PRINT_TOKEN = 258,
     EXIT_TOKEN = 259,
     T_AREA_TOKEN = 260,
     R_AREA_TOKEN = 261,
     C_AREA_TOKEN = 262,
     C_CIRC_TOKEN = 263,
     S_ROOT_TOKEN = 264,
     R_VOL_TOKEN = 265,
     S_VOL_TOKEN = 266,
     C_VOL_TOKEN = 267,
     SIN_TOKEN = 268,
     COS_TOKEN = 269,
     TAN_TOKEN = 270,
     ROOTS_TOKEN = 271,
     FORCE_TOKEN = 272,
     VOLTAGE_TOKEN = 273,
     STRING_TOKEN = 274,
     INT_TOKEN = 275,
     FLOAT_TOKEN = 276,
     VAR_TOKEN = 277,
     DATA_TYPE_TOKEN = 278
   };
#endif
/* Tokens.  */
#define PRINT_TOKEN 258
#define EXIT_TOKEN 259
#define T_AREA_TOKEN 260
#define R_AREA_TOKEN 261
#define C_AREA_TOKEN 262
#define C_CIRC_TOKEN 263
#define S_ROOT_TOKEN 264
#define R_VOL_TOKEN 265
#define S_VOL_TOKEN 266
#define C_VOL_TOKEN 267
#define SIN_TOKEN 268
#define COS_TOKEN 269
#define TAN_TOKEN 270
#define ROOTS_TOKEN 271
#define FORCE_TOKEN 272
#define VOLTAGE_TOKEN 273
#define STRING_TOKEN 274
#define INT_TOKEN 275
#define FLOAT_TOKEN 276
#define VAR_TOKEN 277
#define DATA_TYPE_TOKEN 278



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 22 "nero.y"

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
		

/* Line 2058 of yacc.c  */
#line 117 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
