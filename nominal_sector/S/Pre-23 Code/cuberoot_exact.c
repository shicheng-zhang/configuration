/*This C program is intended as a near_exact cube root calculator
 * to a possible margin of 0.001. All margins tested have been 
 * in the range of 0.001 and below, and this program is an 
 * extension to the exact square root program that I also wrote.
 * Please note that entering non-numerical values as well
 * will result in the program stalling as they are not numbers 
 *  
 */
#include <stdio.h>
#include <stdlib.h>
float rev(float g);
float rev(float g)
{
        return g - (g * 2);
}
float func(float h);
float func(float h)
{
        float r;
        float w;
        float s, d;
        if(h < 0)
        {
                if((rev(h) > 10000)&&(rev(h) <= 999999))
                {
                        r = -0.0001;
                        w = rev(r);
                }
                else if((rev(h) > 329) && (rev(h) <= 349))
                {
                        r = -0.00001;
                        w = rev(r);
                }
                else if((rev(h) > 0)&&(rev(h) < 9999))
                {
                        r = -0.000001;
                        w = rev(r);
                }
                else
                {
                        r = -0.001;
                        w = rev(r);
                }
        }
        else
        {
                if((h > 10000)&&(h <= 999999))
                {
                        r = 0.0001;
                        w = r;
                }
                else if((h > 329) && (h <= 349))
                {
                        r = 0.00001;
                        w = r;
                }
                else if((h > 0)&&(h < 9999))
                {
                        r = 0.000001;
                        w = r;
                }
                else
                {
                        r = 0.001;
                        w = r;
                }        
        }
        if(h < 0)
        {
                while (1)
                {
                        s = r * r * r;
                        r = r - w;
                        d = r * r * r;
                        if((h > s) && (h < d))
                        {
                                h = r - w;
                                break;
                        }
                }
                return h;
        }
        else
        {
                while (1)
                {
                        s = r * r * r;
                        r = r + w;
                        d = r * r * r;
                        if((h > s) && (h < d))
                        {
                                h = r - w;
                                break;
                        }
                }
        }
        return h;
}
int main()
{
        float number, s = 0;
        printf("Enter a number:");
        scanf("%f",&number);
        float ed = number;
        if(number == 0)
        {
                printf("You know the answer to that.\n");
                exit(0);
        }
        else if(number < 0)
        {
                for(int i = -1;i > number;i--)
                {
                        if(i * i * i == number)
                        {
                                printf("Number cube_rt(%f) is %f.\n",number,(float)i);
                                s++;
                        }      
                }        
        }
        else
        {
                for(int i = 1;i < number;i++)
                {       
                        if(i * i * i == number)
                        {
                                printf("Number cube_rt(%f) is %f.\n",number,(float)i);
                                s++;
                        }
                }
        }
        float result;
        if(s == 0)
        {
                result = func(number);
                printf("Number cube_rt(%f) is approx %f.\n",ed,result);
        }
}

