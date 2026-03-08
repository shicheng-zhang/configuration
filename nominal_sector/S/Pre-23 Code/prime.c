/*11/3 2023
# This is a C program written to determine if a number is prime or composite,
# the program runs on a unorthodox algorithm which gives the same effect as 
# the old form prime number algorithm with the add-on that it is negative 
# number compatible and can output results for negative numbers as well, al-
# though the only negative prime is -1. Please not that entering any non-nu-
# merical input will result in an infinite printout of the prompt message,
# which is not the point of this program.
#
# Please also do not plagirise from the program, any form of copy pasteing
# into another program is plagirisation, and may result in penalties if di-
# scovered. If you wish to use the algorithm, please leave a direct refere-
# nce in your own program to the writer(see below)
#
# Copyright 2023, Shicheng.Z
*/
#include <stdio.h>
#include <stdlib.h>
int main()
{
        int number;
        head:
        printf("Enter any number(0 and 1 are not prime or composite but -1 is prime):");
        scanf("%d",&number);
        if((number == 0) || (number == 1))
        {
                printf("Your number is already prime, please reinput.");
                goto head;
        }
        int u = 1;
        int attr_value = 0;
        int attr[abs(number)];
        if(number < 0)
        {
                u = -1;
                while (1)
                {
                        if(u < number)
                        {
                                break;
                        }
                        else
                        {
                                if(number % u == 0)
                                {
                                        attr[attr_value] = u;
                                        attr[attr_value + 1] = number / u;
                                        attr_value = attr_value + 2;
                                }
                                u--;
                        }
                }
        }
        else
        {
                while (1)
                {
                        if(u > number)
                        {
                                break;
                        }
                        else
                        {
                                if(number % u == 0)
                                {
                                        attr[attr_value] = u;
                                        attr_value++;
                                }       
                                u++;
                        }
                }
        }
        if((attr_value == 2))
        {
                if(number > 1)
                {
                        printf("Your number is prime, the only factors are:");
                        for(int h = 0;h < attr_value;h++)
                        {
                                printf("%d ",attr[h]);
                        }
                        printf("\n");
                        exit(0);
                }
                else
                {
                        printf("Your number is prime, the factor pair is:");
                        for(int h2 = 0;h2 < attr_value;h2++)
                        {
                                printf("%d ",attr[h2]);
                        }
                        printf("\n");
                        exit(0);
                }
        }
        else
        {
                if(number > 1)
                {
                        printf("Your number is composite, the factors are:");
                        for(int h1 = 0;h1 < attr_value;h1++)
                        {
                                printf("%d ",attr[h1]);
                        }
                        printf("\n");
                        exit(0);
                }
                else
                {
                        printf("Your negative number is composite, the factor pairs are:");
                        for(int h3 = 0;h3 < attr_value;h3++)
                        {
                                printf("%d ",attr[h3]);
                        }
                        printf("\n");
                        exit(0);
                }
        }
}
