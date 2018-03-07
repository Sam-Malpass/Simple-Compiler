/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 1 "Scanner and Parser/Grammar.y" /* yacc.c:1909  */

#include "../Syntax Tree/Syntax Tree.hpp"

#line 48 "y.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    START = 258,
    LEFT_BRACE = 259,
    RIGHT_BRACE = 260,
    NUMBER = 261,
    NAME = 262,
    HCNUMBER = 263,
    SENTENCE = 264,
    ADD = 265,
    SUB = 266,
    MUL = 267,
    DIV = 268,
    EQS = 269,
    LEFT_BRACKET = 270,
    RIGHT_BRACKET = 271,
    DONE = 272,
    SAY = 273,
    SEMI_COLON = 274
  };
#endif
/* Tokens.  */
#define START 258
#define LEFT_BRACE 259
#define RIGHT_BRACE 260
#define NUMBER 261
#define NAME 262
#define HCNUMBER 263
#define SENTENCE 264
#define ADD 265
#define SUB 266
#define MUL 267
#define DIV 268
#define EQS 269
#define LEFT_BRACKET 270
#define RIGHT_BRACKET 271
#define DONE 272
#define SAY 273
#define SEMI_COLON 274

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef Compiler::SyntaxTree * YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
