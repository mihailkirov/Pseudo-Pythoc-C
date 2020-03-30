#ifndef ASA_H
#define ASA_H 
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <math.h>
#include <string.h>
#include "ts.h"
typedef enum { typeNb, typeOp, typeV } nodeType;

/* types of comp operators */

typedef enum {LEQ, SEQ, EQ} compType;  


/* Types of node */ 

typedef struct{
  int value;
} nodeNb, *pnb;


typedef struct{
  int ope;
  int nops;
  struct node ** node;
} nodeOp;

typedef struct{
	char *c; // charecter letter
}nodeV, *ptrnV;

/* Tree construction */ 

typedef struct node{
  
  nodeType type; // type of de node 
  union {
    nodeNb nb;
    nodeOp op;
    nodeV  oper;
  };
}node, *tree; // pointer to three 



tree create_nodeNb(int value);
tree create_nodeOp(int ope, int nops, ...);
tree create_nodeV(char *c);

void free_node(node *p);
int eval(node *p);


/* data struct stack */

typedef struct stack{
	tree value;
        struct stack *ptr;
}pile, *ppile;


void display_pile();
void empiler(ppile *p, tree n);
tree depiler(ppile *p);
int pile_vide(ppile v);
void free_pile(ppile p);
#endif
