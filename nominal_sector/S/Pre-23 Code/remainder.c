/*This is a C Program written to find the remainder of a division statement without
# using either the % or / operations with integer inputs. The program can also res-
# pond to situations such as if either the divident or divisor are 0, which gives t-
# he appropiate results to each situation, as well as the ability to function with 
# one or both inputs as negative inputs to which it will automatically revert to a 
# different form of the main algorithm used throughout this program. Please note t-
# hat inputting any non-numerical characters will result in a instant random output
# in the divisor section and 0 for all other fields, or random numbers for for the 
# divident and divisor and UDF for all other outputs, or a infinite loop of the pr-
# ompt if arrow keys are inputted.
#
# Please do not use this program as a part of any other program as it has not been
# tested in any other fields other than it's original purpose and can generate err-
# onous answers compared to what the intended answer may be. Thank you.   
#
# Copyright 2023, Shicheng.Z
# March 5th, 2023.
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
    int divisor, divident;
    printf("Enter the divident:");
    scanf("%d",&divident);
    printf("Enter the divisor:");
    scanf("%d",&divisor);
    int u = 1;
    int link = 0;
    int link2 = 0;
    if((divisor < 0) && (divident < 0))
    {
        divisor = divisor - divisor * 2;
        divident = divident - divident * 2;
        link2 = 1;
    }
    if(divisor == 0)
    {
        printf("Remainder = UDF, Quotient = UDF, Divisor = 0, Divident = %d.\n",divident);
        printf("Don't even try to divide by 0 >:(.\n");
        exit(0);
    }
    else if(divident == 0)
    {
        printf("Remainder = 0, Quotient = 0, Divisor = %d, Divident = 0.\n",divisor);
        exit(0);
    }
    else if((divident < divisor) && (divident < 0))
    {
        link = 1;
    }
    else if((divident < divisor) && (divident > 0))
    {
        printf("Remainder = %d, Quotient = 0, Divisor = %d, Divident = %d.\n", divident, divisor, divident);
        exit(0);
    }
    else
    {
        ;
    } 
    if(link == 0)
    {
        while (1)
        {
            if(divisor * u == divident)
            {   
                if(link2 == 1)
                {
                    printf("Remainder = 0, Quotient = %d, Divisor = %d, Divident = %d.\n", u, divisor - divisor * 2, divident - divident * 2);
                }
                else
                {
                    printf("Remainder = 0, Quotient = %d, Divisor = %d, Divident = %d.\n", u, divisor, divident);
                }
                break;
            }
            else
            {
                if(divisor * u > divident)
                {
                    u = u - 1;
                    if(link2 == 1)
                    {
                        printf("Remainder = %d, Quotient = %d, Divisor = %d, Divident = %d.\n", divident - divisor * u, u, divisor - divisor * 2, divident - divident * 2);
                    }
                    else
                    {
                        printf("Remainder = %d, Quotient = %d, Divisor = %d, Divident = %d.\n", divident - divisor * u, u, divisor, divident);
                    }
                    break;
                }
                else
                {
                    u = u + 1;
                }
            }
        }
    }
    else
    {
        u = -1;
        while (1)
        {
            if(divisor * u == divident)
            {   
                printf("Remainder = 0, Quotient = %d, Divisor = %d, Divident = %d.\n", u, divisor, divident);
                break;
            }
            else
            {
                if(divisor * u < divident)
                {
                    u = u + 1;
                    printf("Remainder = %d, Quotient = %d, Divisor = %d, Divident = %d.\n", divident - divisor * u, u, divisor, divident);
                    break;
                }
                else
                {
                    u = u - 1;
                }
            }
        }
    }
}
