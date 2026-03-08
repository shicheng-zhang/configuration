/*This is a C program designed to do Greatest Common Divisor calculations
# using the Eucildian algorithm and has been adapted to be able to do so 
# both negative and positive inputs. Please do not copy and paste it into 
# Your own programs to act as your own algorithm. Entering non-numerical 
# inputs will result in a random output of numbers which are still calc-
# ulated by the program and the output is correct but it will not be the 
# answer to your original input.
#
# March 9th, 2023  Shicheng.Z Copyright 2023*/
#include <stdio.h>
int main()
{
        int input1, input2;
        printf("Enter input 1:");
        scanf("%d",&input1);
        printf("Enter input 2:");
        scanf("%d",&input2);
        int link = 0, link2 = 0;
        if(input1 < 0)
        {
                input1 = input1 - (input1 * 2);
                link++;
        }
        ;
        ;
        if(input2 < 0)
        {
                input2 = input2 - (input2 * 2);
                link2++;
        }
        int temp1, temp2;
        int temp3 = input1;
        int temp4 = input2;
        while (1)
        {
                temp1 = input1 / input2;
                temp2 = input1 % input2;
                if(temp2 == 0)
                {
                        temp1 = input2;
                        break;
                }
                else
                {
                        input1 = input2;
                        input2 = temp2;
                }
        }
        if((link == 1) && (link2 == 1))
        {
                printf("The GCD of {-%d, -%d} = %d\n",temp3,temp4,temp1);
        }
        else if((link == 1) && (link2 == 0))
        {
                printf("The GCD of {-%d, %d} = %d\n",temp3,temp4,temp1);
        }
        else if((link == 0) && (link2 == 1))
        {
                printf("The GCD of {%d, -%d} = %d\n",temp3,temp4,temp1);
        }
        else
        {
                printf("The GCD of {%d, %d} = %d\n",temp3,temp4,temp1);
        }
}