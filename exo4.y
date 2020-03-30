%{
 
 #include <stdio.h>
  #include <ctype.h>
  #include <math.h>  
  #include "ts.h"
  #include "asa.h"  
  
  tsymb table;
  int yylex();
  void yyerror(char *msg);
  FILE* yyin;
%}

%token ID 
%token  NB
%define api.value.type {struct node *}

%token ADD  Eq SUB MULT DIV POW PF PO SEP BO BF 
%token IF ELSE WHILE print
%token EQL SUP INF SUP_EQ INF_EQ DIFF


%right Eq
%left ADD SUB 
%left MULT DIV
%right POW
%start PROG 

%%

PROG : 
|PROG INST { eval($2);}
;

INST: SEP
|EXP SEP {$$ = $1;} 
|MEM SEP{ $$ = $1 ;}  
|LOGI SEP{ $$  = $1;} 
|print EXP SEP{$$ = create_nodeOp('p', 1, $2);}
|print MEM SEP{$$ = create_nodeOp('p', 1,  $2);}
|print LOGI SEP {$$ = create_nodeOp('p', 1, $2);}
|BO INSTS BF{ $$ = $2;}
|WHILE PO LOGI PF INST{ $$ = create_nodeOp('w', 2, $3, $5);}
|IF PO LOGI PF INST ELSE INST{$$ = create_nodeOp('i', 3, $3, $5, $7);}
|IF PO LOGI PF INST {$$ = create_nodeOp('i', 2, $3, $5);}
|MEM Eq EXP {$$ = create_nodeOp('=', 2,  $1, $3);}

INSTS: INST {$$ = $1;}
| INST INSTS { $$ = create_nodeOp('e', 2, $1, $2); }
;
/* Logical expressions */ 
LOGI: EXP EQL EXP {
    $$ = create_nodeOp(EQL, 2, $1, $3); 
 }
|EXP SUP EXP {
    $$ = create_nodeOp('>', 2, $1, $3); 
}
|EXP INF EXP {

    $$ = create_nodeOp('<', 2, $1, $3); 
}
|EXP SUP_EQ EXP {

    $$ = create_nodeOp(SEQ, 2, $1, $3); 
}
|EXP INF_EQ EXP {
    $$ = create_nodeOp(LEQ, 2, $1, $3); 
}

MEM: ID {$$ =  $1;} 


/* Arithmetic Expressions */

EXP : NB {$$ = $1; } 
| EXP ADD EXP    { $$ =  create_nodeOp('+' ,2, $1 , $3);}
| EXP SUB EXP {$$ =  create_nodeOp('-' , 2, $1 , $3);}
| EXP DIV EXP {$$ =  create_nodeOp('/' , 2, $1 , $3);}
| EXP MULT EXP {$$ = create_nodeOp('*' , 2, $1 , $3);}
| PO EXP PF  { $$ = $2;}
| SUB EXP  {$$ = create_nodeOp('-', 1, $2);}
| EXP POW EXP {$$ = create_nodeOp('^', 2, $1, $3);}
| MEM  { $$ = $1 ;}
;
%%

int main(int argc, char* argv[]){
  yyin = fopen(argv[1], "r");
 
  char test = '/';
  table = ts_create_id(&test, 0);
  yyparse();
  ts_free_table(table);
  fclose(yyin);
  return 0;

}

