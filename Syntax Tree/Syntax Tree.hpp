#pragma once
#include <vector>
#include <string>
namespace Compiler
{
	class SyntaxTree
	{
		public:
			SyntaxTree() = default;
			virtual ~SyntaxTree() = default;
			virtual std::string toCode() const = 0;
		protected:
			std::vector<SyntaxTree *> Children;
	};
}