%option noyywrap
%{
#include <iostream>
#include "y.tab.h"
bool DEBUG = false;
%}
alpha		[a-zA-z_]
nums		[0-9]+
name		{alpha}([nums]*{alpha}*)+
whitespace	[ \r\t\v\f]
linefeed	\n
comment1	\/\*(.|\n)*\*\/
comment2	\/\/.*
comment3	\/\*.*
comment4	{name}({whitespace}*{name}*)+\*\/
%%
{comment1}			{ ; }	/* These comment parts will remove comments that are even syntactically incorrect */
{comment2}			{ ; }	/* That should mean no run-time errors when compiling code into C++ source code   */
{comment3}			{ ; }
{comment4}			{ ; }
"start"				{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a start point" << std::endl; return(START); }
"number"			{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a declaration" << std::endl; return(NUMBER); }
"done"				{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected an end point" << std::endl; return(DONE); }
"say"				{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a say" << std::endl; return(SAY); }
{nums}				{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a hard-coded number" << std::endl; return(HCNUMBER); }
{name}				{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a name" << std::endl; return(NAME); }
"="					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected an equals" << std::endl; return(EQS); }
"+"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected an addition" << std::endl; return(ADD); }
"-"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a subtraction" << std::endl; return(SUB); }
"*"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a multiplication" << std::endl; return(MUL); }
"/"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a division" << std::endl; return(DIV); }
";"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a semicolon" << std::endl; return(SEMI_COLON); }
"("					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a left bracket" << std::endl; return(LEFT_BRACKET); }
")"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a right bracket" << std::endl; return(RIGHT_BRACKET); }
"{"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a left brace" << std::endl; return(LEFT_BRACE); }
"}"					{ if(DEBUG == true)std::cout << "[DEBUG] Scanner detected a right brace" << std::endl; return(RIGHT_BRACE); }
{whitespace}
{linefeed}	++yylineno;
.
%%