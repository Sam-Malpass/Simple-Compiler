#pragma once
#include "Syntax Tree.hpp"
namespace Compiler
{
	class Triple : public SyntaxTree
	{
		public:
			Triple(SyntaxTree *item1, SyntaxTree *item2, SyntaxTree *item3)
			{
				Children.push_back(item1);
				Children.push_back(item2);
				Children.push_back(item3);
			}
			virtual ~Triple()
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
