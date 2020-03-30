%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "asa.h"
	
	int yylval;
 	int yylex();
        int yyerror(char *msg);
  	ppile racine = NULL;

%}

%option nounput
%option noinput
OP   [*+-/^]

%%

{OP}   {
	tree x = depiler(&racine);
	tree y = depiler(&racine);
	empiler(&racine, create_nodeOp(yytext[0], 2, y, x));	
	}

[0-9]+  {
	int tmp = atoi(yytext);
	empiler(&racine, create_nodeNb(tmp));
}

\n     {
	tree tmp = depiler(&racine);
	printf("%d\n", eval(tmp));
	free_node(tmp);}
	
[ \t]  { /* ignorer les blancs */ }
.      { fprintf(stderr, "caractere inconnu %c\n", yytext[0]); }

%%

int main(int argc, char*argv[]){
	
	racine  = NULL;	
	yylex();
	return 0;
}

