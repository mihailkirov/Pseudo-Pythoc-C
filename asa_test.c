#include <stdio.h>
#include <stdlib.h>
#include "asa.h"

tsymb tablesym = NULL;

int main(void)
{
  tree p1 ,p3, p4, p6, p7;  
  char test = '\0';
  char *k = calloc(2, sizeof(char));
  k[0] = 'k';
  k[1]='\0';
  char tmp[] = "asa";
  tablesym = ts_create_id(&test, 0);
  
  p1 = create_nodeNb(5);
  p4 = create_nodeNb(2);
  p6 = create_nodeOp(LEQ ,2, p1 ,p4);
  p3 = create_nodeV(tmp);
  p7 = create_nodeOp('=' ,2, p3, p6);
  
  eval(p7);
  eval(p6); 
  ts_print(tablesym);
  free_node(p6);
  free_node(p7); 
  ts_free_table(tablesym);
  return 0;
}
