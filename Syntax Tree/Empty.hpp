#pragma once
#include <string>
#include "Syntax Tree.hpp"
namespace Compiler
{
	class Empty : public SyntaxTree
	{
		public:
			Empty()
			:
				item("")
			{}
			virtual ~Empty() = default;
			virtual std::string toCode() const
			{
				return item;
			}
		private:
			std::string item;
	};
}
