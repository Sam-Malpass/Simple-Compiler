#pragma once
#include "Syntax Tree.hpp"
namespace Compiler
{
	class Double : public SyntaxTree
	{
		public:
			Double(SyntaxTree *item1, SyntaxTree *item2)
			{
				Children.push_back(item1);
				Children.push_back(item2);
			}
			virtual ~Double()
			{
			}
			virtual std::string toCode() const
			{
				std::string code;
				for(SyntaxTree *node : Children)
				{
					if(node != nullptr)
					{
						code += node->toCode();
					}
				}
				return code;
			}
	};
}
