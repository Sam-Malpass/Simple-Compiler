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
int preOp()
{
	cout << "Performing Preliminary Optimization Check" << endl;
	string scode;
	string test;
	ifstream file("Compiled Code/Main.cpp");
	stringstream input;
	input << file.rdbuf();
	scode = input.str();
	file.close();
	istringstream iss(scode);
	vector<string> result (istream_iterator<string>{iss}, istream_iterator<string>{});
	for(int i = 0; i < result.size(); i++)
	{
		test = "";
		if(result[i] == "return")
		{
			i++;
			while(result[i] != "}")
			{
				test += result[i];
				if(is_digits(test) == false)
				{
					return 0;
				}
				i++;
			}
			stringstream geek(test);
			geek >> returnVal;
		}
	}
	return 1;
}
int secondOp()
{
	cout << "Performing Secondary Optimization Check" << endl;
	ifstream file("Compiled Code/Main.cpp");
	string scode;
	stringstream input;
	input << file.rdbuf();
	scode = input.str();
	file.close();
	bool change = false;
	string test = "";
	istringstream iss(scode);
	optimized = "";
	vector<string> result (istream_iterator<string>{iss}, istream_iterator<string>{});
	int i = 16;
	while(i < result.size())
	{
		if(is_digits(result[i]) == true)
		{
			i++;
		}
		test += result[i] + " ";
		if(test == "return ")
		{
			i++;
			optimized += test + result[i];
		}
		if(is_end(test) == false)
		{
			optimized += test + "\n";
			test = "";
		}
		else
		{
			change = true;
		}
		i++;
	}
	if(change == true)
	{
		return 1;
	}
	return 0;
}
