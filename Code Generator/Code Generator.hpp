#pragma once
#include <iostream>
#include <fstream>
#include <memory>
#include "../Syntax Tree/Syntax Tree.hpp"
#include "../Optimizer/Optimizer.hpp"
extern std::unique_ptr<Compiler::SyntaxTree> root;
extern int returnVal;
using namespace std;
extern string optimized;
int generate()
{
	cout << "Performing intial generation" << std::endl;
	ofstream file;
	file.open("Compiled Code/Main.cpp");
	file << "/*C++ Code Generated Using SamC to C++ Compiler by Sam Malpass*/" << std::endl;
	file << "#include <iostream>" << endl;
	file << "int main()\n{" << endl;
	file << root->toCode() << endl;
	file << "}" << endl;
	file << "/*Compile C++ Code Yourself*/";
	file.close();
	if(preOp() == 1)
	{
		cout << "Optimization technique found" << endl;
		file.open("Compiled Code/Main.cpp");
		file << "/*C++ Code Generated Using SamC to C++ Compiler by Sam Malpass*/" << endl;
		file << "#include <iostream>" << endl;
		file <<"int main()\n{" << endl;
		file <<"return " << returnVal << ";" << endl;
		file << "}" << endl;
		file << "/*Compile C++ Code Yourself*/";
		file.close();
	}
	if(secondOp() == 1)
	{
		cout << "Optimization technique found" << endl;
		file.open("Compiled Code/Main.cpp");
		file << "/*C++ Code Generated Using SamC to C++ Compiler by Sam Malpass*/" << endl;
		file <<"#include <iostream>" << endl;
		file << "int main()\n{" << endl;
		file << optimized;
		file << "\n}" << endl;
		file << "/*Compile C++ Code Yourself*/";
		file.close();
	}
	cout << "Generation complete" << endl;
	return 0;
}