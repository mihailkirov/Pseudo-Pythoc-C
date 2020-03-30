#ifndef TS_H
#define TS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct tsymb{
  char *id;
  int val;
  struct tsymb *next;
} table_symb, *tsymb;   


/* 
   cree une structure de type tsymb initialisée avec les valeurs
   <id> et <val>
*/
tsymb ts_create_id(char *id, int val);

/* 
   affecte la valeur <val> à l'identificateur <id> s'il existe dans la
   table, l'ajoute en fin de table sinon   
 */
void ts_assign_value(tsymb t, char *id, int val);

/*
  retourne la valeur de l'identificateur <id>
*/
int ts_get_value(tsymb t, char *id);

void ts_free_table(tsymb t);
void ts_print(tsymb t);

#endif
