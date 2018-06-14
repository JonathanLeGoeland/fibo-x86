#include "cdecl.h"
#include <stdio.h>
#include <stdlib.h>
/* 
This program computes firbonacci numbers in a different manner than
previously.

The assembler computes an array of numbers.  C language get the number
of numbers and print the array.
*/


int PRE_CDECL calc_fibo_1(unsigned int*, int ) POST_CDECL;

int main(int argc, char** argv)
{
    int ret_status;
    int N;
    unsigned int * array = NULL;
    if (argc==2)
      {
	N  = atoi(argv[1]);
	array = malloc(N*sizeof(unsigned int));
	for (int i=0; i<N; i++)
	  array[i]=0;
	
	// 1 -- Fill the array
	ret_status = calc_fibo_1(array, N);
	
	// 2 -- Display the array
	for (int i=0; i<N; i++)
	  printf("Fibo[%d] = %u\n", i, array[i]);

	// 3 -- Free memory
	if (array == NULL)
	  free(array);
	return ret_status;
      }
    else
      {
	printf("Help: Computes N first Fibonacci numbers.\n");
	printf("  Usage: %s <N>.\n", argv[0]);
	return 1;
      }
}
