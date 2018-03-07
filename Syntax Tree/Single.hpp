#pragma once
#include "Syntax Tree.hpp"
namespace Compiler
{
	class Single : public SyntaxTree
	{
		public:
			Single(SyntaxTree *item)
			{
				Children.push_back(item);
			}
			virtual ~Single()
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