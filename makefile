calc : calc.y analex.lex 
	bison -o calc.c -d calc.y
	flex -o analex.c analex.lex
	gcc -Wall -o calc calc.c analex.c ts.c -lfl -lm


asa_test:
	gcc -Wall  asa_test.c asa.c -o $@ 


exo3_bis: lexasa.c asa.c datastructs.c ts.c
	gcc $^ -lfl -lm -o $@

exo3: asa.c ts.c asa_test.c
	gcc $^ -Wall -lm -o $@

lexasa.c: lexasa.lex 
	flex -o $@ $<

asa.o: asa.c asa.h
	gcc -c $<
ts.o: ts.c ts.h
	gcc -c $<

COMPILO:  
	bison -o exo4.c -d exo4.y
	flex -o exo.c exo4.lex
	gcc -Wall -g exo4.c exo.c datastructs.c ts.c asa.c -lfl -lm -o $@
	
