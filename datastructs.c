#include "asa.h"


/* Initialising stack from afn intitial states set 
 * The function has 2 states , with binary masc and without */


void empiler(ppile *p, tree n) // _pile_ *
{
	ppile v  = calloc(1, sizeof(pile));
	v->value = n;
	v->ptr = *p;
	*p = v ; 
	
}	


tree depiler(ppile *p )
{
	
	if(!pile_vide(*p))
	{	
		printf("Stack already empty \n");
		exit(1);
	}
	
	ppile g = *p ;
	*p = (*p)->ptr; 
	tree tmp = g->value;
	free(g);
	return tmp;

}



int pile_vide(ppile v )
{
	if(!v) // <==> v->ptrs == NULL  
		return 0;

	return 1 ;
}

/* Free memory space of the liste chainee */ 
void free_pile(ppile p){
	
	while(!pile_vide(p)){
		ppile tmp = p;
		p = p->ptr;
		free(tmp);
	}
	
	free(p);
}
