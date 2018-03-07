#pragma once
#include <string>
#include "Syntax Tree.hpp"
#include "../Translator Unit/Translator.hpp"
namespace Compiler
{
	class Changed : public SyntaxTree
	{
		public:
			Changed(const std::string &item)
			:
				item(translate(item))
			{}
			virtual ~Changed() = default;
			virtual std::string toCode() const
			{
				return item;
			}
		private:
			std::string item;
	};
}
