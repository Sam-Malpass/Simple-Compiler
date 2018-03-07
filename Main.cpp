#include <iostream>
#include <memory>
#include "Code Generator/Code Generator.hpp"
#include "Syntax Tree/Syntax Tree.hpp"
extern int yyparse();
extern std::unique_ptr<Compiler::SyntaxTree> root;
int main()
{
	int result = yyparse();
	if(result == 0)
	{
		generate();
		std::cout << "Compilation Successful" << std::endl;
	}
	else
	{
		std::cout << "Compilation Failed" << std::endl;
	}
	return result;
}