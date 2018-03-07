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