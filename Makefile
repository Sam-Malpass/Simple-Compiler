all:
	$(MAKE) Grammar
	$(MAKE) Lex
	g++ -g -std=c++11 -Wall -Wextra Scanner\ and\ Parser/y.tab.c Scanner\ and\ Parser/lex.yy.c Main.cpp -o Executable/Compiler.exe

Grammar:
	yacc -d Scanner\ and\ Parser/Grammar.y
	mv y.tab.* Scanner\ and\ Parser

Lex:
	flex Scanner\ and\ Parser/Lex.l
	mv lex.yy.c Scanner\ and\ Parser

Run:
	$(MAKE) all
	./Executable/Compiler.exe < Test\ Code/Test\ Program 
	
