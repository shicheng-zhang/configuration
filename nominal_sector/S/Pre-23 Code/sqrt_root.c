/*This is a C program designed to determine the exact square root 
# of a number to a margin of 0.000001 at the least, this program, 
# unlike the approximation program, uses a brute force method which
# gives better results, However, please note that the numbers between
# 331 to 349 have a bug in the system that cannot be resolved, and thus
# the preciseness has been lowered for those numbers so as not to 
# trigger a seg fault when the program is run. The program is inte-
# nded for numbers below 1 million, however, it can run with numbers
# above 1 million, but also with lowered accuracy so as not to seg 
# fault the system. Both special cases have a higher margin of error
# to within 0.001 in most tested cases, with some other numbers
# also giving higher margins as well. If you find any number with
# a margin higher than 0.01, please send the number to me so the pr-
# ogram/bug can be corrected. Float inputs will be auto rounded to the 
# lower whole number when calculating OR in some cases trigger a seg
# fault.
#
# Some numbers' square roots are exactly equal to those on calculators
# <:).
#
# Please do not copy paste into your own programs and please give cr-
# eidt if you must for any reason >:(
#
# 16th March, 2023.  Shicheng.Z
*/

#include <stdio.h>

float func(float h);
float func(float h)
{
        float r;
        float w;
        float s, d;
        if((h > 10000)&&(h <= 999999))
        {
                r = 0.0001;
                w = r;
        }
        else if((h > 329) && (h <= 349))
        {
                r = 0.00001;
                w = r;
                goto head;
        }
        else if((h > 1000)&&(h < 9999))
        {
                r = 0.000001;
                w = r;
        }
        else
        {
                r = 0.001;
                w = r;
        }
        head:
        while (1)
        {
                s = r * r;
                r = r + w;
                d = r * r;
                if((h > s) && (h < d))
                {
                        h = r - w;
                        break;
                }
        }
        return h;
}
int main()
{
        int number, s = 0;
        printf("Enter a number prefereably <= than 1 million:");
        scanf("%d",&number);
        int ed = number;
        for(int i = 1;i < number;i++)
        {
                if(i * i == number)
                {
                        printf("Number sqrt(%d) is %d.\n",number,i);
                        s++;
                }
        }
        float result;
        if(s == 0)
        {
                result = func(number);
                printf("Number sqrt(%d) is approx %f.\n",ed,result);
        }
}

