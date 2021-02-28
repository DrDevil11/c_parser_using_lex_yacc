%token INCLUDE
%token DEFINE
%token id
%token LPB
%token RPB
%token INVC
%token INT
%token FLOAT
%token CHAR
%token datatype
%token STRING
%token EQUAL
%token LCB
%token RCB
%token relations
%token FOR
%token IF
%token ELSEIF
%token ELSE
%left '+' '-'
%left '*' '/' '%'
%start program
%{
#include<stdio.h>
void yyerror();
int yylex();
%}

%%

program : line program
        | 
        ;

line    : hash
        | dec
        | loop
        | comp
        | id EQUAL exp ';'              {printf("expression\n");}  
        ;
        
hash    :INCLUDE LPB id RPB            {printf("include file\n");}
        |INCLUDE INVC id INVC          {printf("include file\n");}
        |DEFINE id id                  {printf("hash define\n");}
        |DEFINE id E                   {printf("hash define\n");}
        |DEFINE id datatype
        |DEFINE datatype id
        ;

dec     : datatype id ';'              {printf("var declaration\n");}
        | datatype id EQUAL Z';'        {printf("var declaration\n");}
        | datatype id LCB funcexp RCB ';'   {printf("function\n");}
        | datatype id LCB RCB ';'        {printf("function\n");}
        ;

loop    :FOR LCB datatype id EQUAL Z ';' relstat ';' id EQUAL exp RCB {printf("for loop\n");}
        ;

comp    : IF LCB relstat RCB          {printf("IF statement\n");}
        | ELSEIF LCB relstat RCB      {printf("else if statement\n");}
        | ELSE                        {printf("else statement\n");}
        ;

relstat :id relations E
        |E relations id
        |id relations id
        |E relations E
        |E LPB E
        |E RPB E
        |id LPB E
        |E LPB id
        |id LPB id
        |id RPB E
        |E RPB id
        |id RPB id
        ;

exp     :Z
        |exp '+' exp
        |exp '-' exp
        |exp '*' exp
        |exp '/' exp
        |exp '%' exp
        |'(' exp ')'
        ;

Z       :id
        |E
        ;
 
funcexp :datatype id ',' funcexp 
        |datatype id EQUAL E ',' funcexp
        |datatype id
        |datatype id EQUAL E
        ;

E       :INT
        |FLOAT
        |CHAR
        |STRING
        ;


%%

int main()
{
yyparse();
return 0;
}
void yyerror()
{
	printf("error");
}