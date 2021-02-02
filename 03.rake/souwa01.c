/********************/
/*  総和を計算する  */
/********************/
#include <stdio.h>
int  main( )
{
    int  sum=0,i=1;

    while( i<=100 )
      {
        sum+=i;
        i++;
      }

    printf("\n1 から 100 までの総和は %d です\n",sum);

    return 0;
}

