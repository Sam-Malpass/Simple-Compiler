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