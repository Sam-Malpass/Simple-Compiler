#pragma once
#include <string>
#include "Syntax Tree.hpp"
namespace Compiler
{
	class Unchanged : public SyntaxTree
	{
		public:
			Unchanged(const std::string &item)
			:
				item(item)
			{}
			virtual ~Unchanged() = default;
			virtual std::string toCode() const
			{
				return item;
			}
		private:
			std::string item;
	};
}
