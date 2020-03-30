%{
  #include "calc.h"
%}
  
%option nounput
%option noinput

%%

"+"    { return ADD;}
"-"    {return SUB;}
"**" {return POW;}
"*" {return MULT;}
"="    {return EQ;}
"("    {return PO;} 
")"    {return PF;}
">"    	{return SUP;}
"<" 	{return INF;}
"<=" 	{return INF_EQ;}
">=" 	{return SUP_EQ;}
"==" 	{return EQL;}
[0-9]+  { yylval.nb = atoi(yytext); return NB;}
[A-Z]+  { strcpy(yylval.id, yytext); return ID;}
\n     { return EOL;}
[ \t]  { /* ignorer les blancs */ }
.      { fprintf(stderr, "caractere inconnu %c\n", yytext[0]); }

%%
