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