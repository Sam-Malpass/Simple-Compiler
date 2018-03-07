#include <iostream>
#include <memory>
#include "Code Generator/Code Generator.hpp"
#include "Syntax Tree/Syntax Tree.hpp"
extern int yyparse();
extern std::unique_ptr<Compiler::SyntaxTree> root;