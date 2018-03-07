%code requires{
#include "../Syntax Tree/Syntax Tree.hpp"
}
%{
#include <iostream>
#include <memory>
#include "../Syntax Tree/Includes.hpp"
std::unique_ptr<Compiler::SyntaxTree> root;
int yylex(void);
extern char *yytext;
void yyerror(char const *);
bool PDEBUG = false;
%}
%define api.value.type {Compiler::SyntaxTree *}
%token START LEFT_BRACE RIGHT_BRACE
%token NUMBER NAME HCNUMBER SENTENCE
%token ADD SUB MUL DIV EQS LEFT_BRACKET RIGHT_BRACKET
%token DONE SAY
%token SEMI_COLON
%start input
%%
input:
	function function_list									{ root.reset(new Compiler::Double($1, $2)); }
function_list:
	function function_list									{ $$ = $1; }
	| %empty												{ $$ = nullptr; }
	;
function:
	START LEFT_BRACE statements RIGHT_BRACE 				{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing function" << std::endl; $$ = new Compiler::Double($1, $3); }
	| START statements RIGHT_BRACE							{ $$ = new Compiler::Double($1, $2); }
	| START LEFT_BRACE statements							{ $$ = new Compiler::Double($1, $3); }
	| START statements										{ $$ = new Compiler::Double($1, $2); }
	| statements											{ $$ = new Compiler::Double($1, new Compiler::Empty()); }
	;
statements:
	statements statement									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing statement" << std::endl; $$ = new Compiler::Double($1, $2); }
	| %empty												{ $$ = nullptr; }
	;
statement:
	return stateend											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing 'DONE'" << std::endl; $$ = new Compiler::Double($1, $2); }
	| declaration stateend									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing declaration" << std::endl; $$ = new Compiler::Double($1, $2); }
	| decassignment stateend								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing declartion & assignment" << std::endl; $$ = new Compiler::Double($1, $2);}
	| assignment stateend									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing assignment" << std::endl; $$ = new Compiler::Double($1, $2); }
	| expression stateend									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression" << std::endl; $$ = new Compiler::Double($1, $2); }
	| output stateend										{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing output" << std::endl; $$ = new Compiler::Double($1, $2); }
	| wrong													{ std::cout << "[WARNING] SYNTAX ERROR REMOVED" << std::endl; $$ = new Compiler::Double(new Compiler::Empty(), new Compiler::Empty()); }
	| return												{ std::cout << "[WARNING] FIXING BROKEN CODE" << std::endl; $$ = new Compiler::Double($1, new Compiler::StateEnd(";")); }
	| output												{ std::cout << "[WARNING] FIXING BROKEN CODE" << std::endl; $$ = new Compiler::Double($1, new Compiler::StateEnd(";")); }
	;
wrong:
	name stateend
	| name
	| expression
	| hardcoded stateend
	| hardcoded
	| type hardcoded
	| type name
	| type hardcoded stateend
	| assignment
	| decassignment
	| declaration
	| say hardcoded
	| say expression
	| say hardcoded stateend
	| say expression stateend
	;
return:
	fin hardcoded											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing done with number" << std::endl; $$ = new Compiler::Double($1, $2); }
	| fin name												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing done with variable" << std::endl; $$ = new Compiler::Double($1, $2); }
	| fin expression										{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing done with expression" << std::endl; $$ = new Compiler::Double($1, $2); }
	| fin													{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing done alone" << std::endl; $$ = new Compiler::Double($1, new Compiler::Unchanged("0")); }
	;
addfunc:
	name add name											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name + name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }			
	| name add hardcoded									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name + number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }							
	| hardcoded add name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number + name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }	
	| hardcoded add hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number + number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name add expression									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name + expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded add expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number + expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression add name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression + name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression add hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression + number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression add expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression + expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;	
subfunc:
	name sub name											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name - name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name sub hardcoded									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name - number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded sub name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number - name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded sub hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number - number" <<std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name sub expression									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name - expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded sub expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number - expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression sub name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression - name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression sub hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression - number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression sub expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression - expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;
mulfunc:
	name mul name											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name * name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name mul hardcoded									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name * number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded mul name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number * name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded mul hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number * number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name mul expression									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name * expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded mul expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number * expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression mul name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression * name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression mul hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression * number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression mul expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression * expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;
divfunc:
	name div name											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name / name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name div hardcoded									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name / number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded div name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number / name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded div hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number / number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name div expression									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name / expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| hardcoded div expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number / expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression div name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression / name" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression div hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression / number" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| expression div expression								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression / expression" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;
bracketed:
	lbracket name rbracket									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing name in brackets" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| lbracket hardcoded rbracket							{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing number in brackets" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| lbracket expression rbracket							{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing expression in brackets" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;
assignment:
	name eqs hardcoded										{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing assignemnt" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| name eqs expression									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing assignment" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;	
decassignment:
	declaration eqs hardcoded								{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing decassignment" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| declaration eqs name									{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing decassingment" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	| declaration eqs expression							{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing decassignment" << std::endl; $$ = new Compiler::Triple($1, $2, $3); }
	;
declaration:
	type name												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing declaration" << std::endl; $$ = new Compiler::Double($1, $2); }
output:
	say name												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing variable output" << std::endl; $$ = new Compiler::Double($1, $2); }
name:
	NAME													{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing a name'"<< std::endl; $$ = new Compiler::Unchanged(yytext); }
type:
	NUMBER													{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing variable type" << std::endl; $$ = new Compiler::Changed(yytext); }
stateend:
	SEMI_COLON												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing semi colon" << std::endl; $$ = new Compiler::Unchanged(yytext); }
hardcoded:
	HCNUMBER												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing hardcoded value" << std::endl; $$ = new Compiler::Unchanged(yytext); }
fin:
	DONE													{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing done statement" << std::endl; $$ = new Compiler::Changed(yytext); }
add:
	ADD														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing addition symbol" << std::endl; $$ = new Compiler::Unchanged(yytext); }
sub:
	SUB														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing subtraction symbol" << std::endl; $$ = new Compiler::Unchanged(yytext); }
mul:
	MUL														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing multiplication symbol" << std::endl; $$ = new Compiler::Unchanged(yytext); }
div:
	DIV														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing division symbol" << std::endl; $$ = new Compiler::Unchanged(yytext); }
eqs:
	EQS														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing equals symbol" << std::endl; $$ = new Compiler::Unchanged(yytext); }
lbracket:
	LEFT_BRACKET											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing left bracket" << std::endl; $$ = new Compiler::Unchanged(yytext); }
rbracket:
	RIGHT_BRACKET											{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing right bracket" << std::endl; $$ = new Compiler::Unchanged(yytext); }
say:
	SAY														{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing say statement" << std::endl; $$ = new Compiler::Changed(yytext); }
expression:
	addfunc													{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing addfunc expression" << std::endl; $$ = new Compiler::Single($1); }	 
	| subfunc												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing subfunc Single" << std::endl; $$ = new Compiler::Single($1); }
	| mulfunc												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing mulfunc Single" << std::endl; $$ = new Compiler::Single($1); }
	| divfunc												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing divfunc Single" << std::endl; $$ = new Compiler::Single($1); }
	| bracketed												{ if(PDEBUG == true)std::cout << "[DEBUG] Parsing bracketed Single" << std::endl; $$ = new Compiler::Single($1); }
	;
%%
void yyerror(char const *s)
{
	std::cout << "Error found: " << s << std::endl;
	exit(1);
}