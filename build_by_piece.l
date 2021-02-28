%{
#include<stdio.h>
#include "y.tab.h"

%}

%%
"#include"              return INCLUDE;
"#define"               return DEFINE;

"for"                   return FOR;
"if"                    return IF;
"else if"               return ELSEIF;
"else"                  return ELSE;

"<"                     return LPB;
">"                     return RPB;
["]                     return INVC;
["="]                   return EQUAL;
["("]                     return LCB;
[")"]                     return RCB;

"+"|"-"|"*"|"%"|"/"|","|";"                return yytext[0];

"=="|"!="|"<="|">="         return relations;

"int"|"char"|"float"|"double"|"void" return datatype;


[a-zA-Z][a-zA-Z0-9]*    return id;
[0-9]+                  return INT;
[A-z]                   return CHAR;
[-'.'0-9][0-9]*         return FLOAT;
["][A-z]*["]            return STRING;         
[ \t\n]                 ;
%%

int yywrap()
{
	return 1;
}