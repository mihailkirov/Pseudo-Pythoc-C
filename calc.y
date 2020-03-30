%{
  #include <stdio.h>
  #include <ctype.h>
  #include <math.h>  
  #include "ts.h"
  
  int yylex();
  void yyerror(char *msg);
  tsymb table;
%}

%union{
	int nb;
	char id[256];
}

%token <nb> NB 
%token <id> ID
%type <nb> EXP
%type <nb> LOGI
%type <nb> MEM


%token  ADD EOL  EQ SUB MULT DIV POW PF PO
%token EQL SUP INF SUP_EQ INF_EQ DIFF
%right EQ
%left ADD SUB 
%left MULT DIV
%right POW
%start PROG 

%%

PROG : 
|PROG EXP EOL {
  printf("= %d\n", $2 );
  printf("> ");
 }
 |PROG MEM EOL 
 |PROG LOGI EOL 

;

LOGI: EXP EQL EXP {$$ = $1 == $3 ;} /* for logic operations */
|EXP SUP EXP {printf("%d \n", $1 > $3);}
|EXP INF EXP {printf("%d\n", $1 < $3);}
|EXP SUP_EQ EXP {printf("%d\n", $1 >= $3);}
|EXP INF_EQ EXP {printf("%d \n", $1 == $3);}
|MEM SUP MEM {printf("%d\n", $1 > $3);}
|MEM INF MEM {printf("%d \n",$1 < $3);}
|MEM SUP_EQ MEM {printf("%d\n", $1>=$3);}
|MEM INF_EQ MEM {printf("%d\n", $1<=$3);}
|MEM EQL MEM {printf("%d \n", $1 ==$3);}


MEM: ID {
   int tmp =  ts_get_value(table, $1);
   $$ = tmp;
   printf("%s=%d\n", $1, tmp);   
} 

|ID EQ EXP {ts_assign_value(table, $1, $3);}
|ID ADD ID {
	int tmp = ts_get_value(table, $1) + ts_get_value(table, $3); 
	ts_assign_value(table, $1, tmp);
}

|ID EQ ID SUB ID{
	int tmp = ts_get_value(table, $3) - ts_get_value(table, $5); 
	ts_assign_value(table, $1, tmp);
}

|ID EQ ID POW ID{
	int tmp = pow(ts_get_value(table, $3), ts_get_value(table, $5)); 
	ts_assign_value(table, $1, tmp);
}

|ID EQ ID {ts_assign_value(table, $1, ts_get_value(table, $3));}


EXP : NB { $$ = $1; } 
| EXP ADD EXP    { $$ = $1 + $3;}
| EXP SUB EXP {$$ = $1 - $3;}
| EXP DIV EXP {$$ = $1 / $3;}
| EXP MULT EXP {$$ = $1*$3;}
| PO EXP PF  { $$ = $2;}
| SUB EXP  {$$= -$2;}
| EXP POW EXP {$$ = pow($1, $3);}
;
%%

int main( void ) {
  char test = 'a';
  table = ts_create_id(&test, 0);
  printf("> ");
  yyparse() ;
  ts_free_table(table);
}

void yyerror(char *msg) {
  printf("\n%s\n", msg);
}
