%{
#include "exo4.h" 
#include "asa.h"

%}

%option nounput
%option noinput

%%

"+"    { return ADD;}
"-"    {return SUB;}
"^" {return POW;}
"*" {return MULT;}
"="    {return Eq;}
"("    {return PO;} 
")"    {return PF;}
">"    	{return SUP;}
"<" 	{return INF;}
"<=" 	{return INF_EQ;}
">=" 	{return SUP_EQ;}
"==" 	{return EQL;}
[0-9]+  { yylval = create_nodeNb(atoi(yytext)); return NB;}
[A-Z]+  { yylval = create_nodeV(yytext); return ID;}
[ \n\t]     { /* Fait rien */ }
"{"    { return BO;}
"}"    {return BF;}
";"      {return SEP;}
"print" { return print;}
"if"  {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
.      {fprintf(stderr, "caractere inconnu %c\n", yytext[0]);}

%%
