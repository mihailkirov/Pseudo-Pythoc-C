#include "asa.h"

extern tsymb table;

tree create_nodeNb(int value)
{
  tree p = calloc(1, sizeof(node));
  p->type = typeNb;
  p->nb.value = value;
  return p;
}

tree create_nodeV(char *c){
	tree p = calloc(1, sizeof(node));
	p->type = typeV;
	int lenght = strlen(c);
	p->oper.c = calloc(lenght + 1, sizeof(char));
	strcpy(p->oper.c, c);
	p->oper.c[lenght] = '\0';
	return p;
}

tree create_nodeOp(int ope, int nops, ...)
{
  tree p = calloc(1, sizeof(node));
  p->type = typeOp;
  p->op.ope = ope; //operator
  p->op.nops = nops; // number of operands
  p->op.node = calloc(nops, sizeof(tree));
	
  /* Variadic functions */

  va_list someArgPtr;
  va_start(someArgPtr, nops);
  for(int i=0; i<nops; i++)
  	(p->op.node)[i] = va_arg(someArgPtr, tree); // tree pointers
  
  va_end(someArgPtr);
  
  return p;
}
void free_node(tree p)
{	
     if(p->type == typeOp){
	     for(int i=0; i<p->op.nops; i++)
		     free_node(p->op.node[i]);
	free(p->op.node);	
}     
     else if(p->type == typeV)
	free(p->oper.c);
     
    free(p);
}

int eval(tree p)
{
   if (p->type == typeOp){
	 switch(p->op.ope){
	   case '+':
	 	return eval(p->op.node[0]) +  eval(p->op.node[1]);   
	   	break;
	   case '-':	
		if(p->op.nops == 2)
		return eval(p->op.node[0]) -  eval(p->op.node[1]);   
		else 
		return -eval(p->op.node[0]);  
		break;
	   case '*':
	 	return eval(p->op.node[0]) *  eval(p->op.node[1]);   
	 	break;
	   case '/' :
		return eval(p->op.node[0]) /  eval(p->op.node[1]);  
  	    
	   case '^': // puissance
		return pow(eval(p->op.node[0]), eval(p->op.node[1])); 
	   
	   case '=':
		ts_assign_value(table, p->op.node[0]->oper.c, eval(p->op.node[1]));
	   break;
	   case '>':
		return eval(p->op.node[0]) >  eval(p->op.node[1]); 
	   case '<':	
		return eval(p->op.node[0]) < eval(p->op.node[1]); 
	  case LEQ:
		return eval(p->op.node[0]) <= eval(p->op.node[1]); 
  
	  case SEQ:
		return eval(p->op.node[0]) >= eval(p->op.node[1]); 
 
	  case EQ:
		return eval(p->op.node[0]) == eval(p->op.node[1]); 
	  case 'w':
		while(eval(p->op.node[0])) eval(p->op.node[1]);
	 	break;
	  case 'p':
		return printf("%d \n ", eval(p->op.node[0])); 
	 	
	  case 'e':
		eval(p->op.node[0]);
		eval(p->op.node[1]);
		break;
	  
	  case 'i':
		if (p->op.nops == 2){
			if(eval(p->op.node[0]))
				eval(p->op.node[1]);
	
		}
		else{
			if(eval(p->op.node[0]))
				eval(p->op.node[1]);
			else 
			    eval(p->op.node[2]);
		}
		break;	   	
	 }
   
   }
  else if(p->type == typeV){
		  
	   int tmp = ts_get_value(table, p->oper.c);   	
	   
	   if(tmp != -1) return tmp; 
	   printf("%s  Variable not defined \n", p->oper.c);
   }
   else
   return p->nb.value;

}

int yyerror(char * s)
{	
	printf("invalid expressions %s\n", s);
	return 0;
}
