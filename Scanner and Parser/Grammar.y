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
	function function_list			{ root.reset(new Compiler::Double($1, $2)); }