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