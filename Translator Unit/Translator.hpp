#pragma once
#include <string>
using namespace std;
string translate(string X)
{
	std::string translated;
	if(X == "number")
	{
		translated = "int ";
		return translated;
	}
	else if(X == ";")
	{
		translated = ";\n";
		return translated;
	}
	else if(X == "done")
	{
		translated = "return ";
		return translated;
	}
	else if(X == "say")
	{
		translated = "std::cout << ";
		return translated;
	}
	else
	{
		translated = "";
		return translated;
	}
}