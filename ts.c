#include "ts.h"

tsymb ts_create_id(char *id, int val)
{
  tsymb t = calloc(1, sizeof(table_symb));
  t->val = val;
  int size= strlen(id); 
  t->id = calloc(size, sizeof(char));
  strcpy(t->id,id); 
  t->next = NULL;
  return t;
}

void ts_assign_value(tsymb t, char *id, int val)
{
    tsymb tmp = t;
    while(tmp->next){
    	if(!strcmp(tmp->id, id)){
		tmp->val = val;
		return;
	}
    	tmp = tmp->next;
    }  
    
    if(!strcmp(tmp->id, id)){
		tmp->val = val;
		return;
    }
    tmp->next = ts_create_id(id, val);
}

int ts_get_value(tsymb t, char *id)
{
    tsymb tmp = t;
    while(tmp){
	if(!strcmp(tmp->id, id))
		return tmp->val;
	tmp = tmp->next;
    }
    // not found  ERROR 
    
    return -1;
  
}

void ts_free_table(tsymb t)
{
	while(t){
		tsymb tmp = t;
		t = t->next;
		free(tmp->id);
		free(tmp);
	}
}

void ts_print(tsymb t)
{
    tsymb tmp = t;
    while(tmp){
	 printf("value - %d of %s \n", tmp->val, tmp->id);
    	 tmp = tmp->next;
    }
    
    printf("\n");

}



