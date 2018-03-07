#pragma once
#include <fstream>
#include <string>
#include <sstream>
#include <iostream>
#include <vector>
#include <iterator>
int returnVal;
using namespace std;
string optimized;
bool is_digits(const string &str)
{
	return str.find_first_not_of("0123456789;+-*/()") == string::npos;
}
bool is_end(const string &str)
{
	return str.find_first_of(";") == string::npos;
}