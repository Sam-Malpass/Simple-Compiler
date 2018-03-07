all:
	$(MAKE) Grammar
	$(MAKE) Lex
	g++ -g -std=c++11 -Wall -Wextra Scanner\ and\ Parser/y.tab.c Scanner\ and\ Parser/lex.yy.c Main.cpp -o Executable/Compiler.exe
