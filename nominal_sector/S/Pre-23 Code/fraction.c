/* Copyright 2023 Shicheng.Z 
 *
 * This program is intended as a fraction calculator which adds, subtracts,
 * multiplies, and divides all fractions within the INT_MAX realm. Results
 * are automatically simplified and converted into mixed numbers if needed
 * to give the most direct result, similar to a normal calculator.
 * 
 * Please note that this program does not have any purposes of cryptography
 * and please do not use it in other pieces of code to do as it was not in-
 * tended to do as it has not been tested in those areas and results may be
 * not what may be originally expected. Results may vary with different pu-
 * rposes in different programs.
 * 
 * Note: Any non-integer input will instantly result in a infinite printout 
 * of the value prompts.   
 * 
 * Created on February 26th, 2023.
 */
#include <stdio.h>
#include <stdlib.h>
int main()
{
    int denomonator, numerator, denomonator2, numerator2, temp1, temp2, temp3, temp4, action_function;
    head:
    printf("Enter the numerator:");
    scanf("%d",&numerator);
    printf("Enter the denomonator:");
    scanf("%d",&denomonator);
    printf("Enter numerator 2:");
    scanf("%d",&numerator2);
    printf("Enter denomonator 2:");
    scanf("%d",&denomonator2);
    printf("Enter the function please:");
    scanf("%d",&action_function);
    if((action_function > 4) || (action_function < 1))
    {
        printf("Invalid Command.\n");
        goto head;
    }
    if((denomonator2 == 0) || (denomonator == 0))
    {
        printf("Your fraction is UDF(Undefined as 0 was denomonator)\n");
        exit(0);
    }
    else if((numerator == 0) || (numerator2 == 0))
    {
        printf("Your fraction is 0(Numerator was 0(0 x h / n = 0))\n");
        exit(0);
    }
    else
    {  
    if(action_function == 1)
    {
        if(denomonator2 == denomonator)
        {
            temp1 = numerator + numerator2;
            temp2 = denomonator;
            if(temp2 == temp1)
            {
                printf("Your fraction result is equal to 1(Specific: %d / %d)\n",temp1,temp2);
            }
            else
            {
                if((temp1 % temp2 == 0) || (temp2 % temp1 == 0))
                {
                    if(temp1 % temp2 == 0)
                    {
                        temp1 = temp1 / temp2;
                        temp2 = 1;
                    }
                    else
                    {
                        temp2 = temp2 / temp1;
                        temp1 = 1;
                    }
                }
                else
                {
                    if(temp2 > temp1)
                    {
                        for(int i = 2;i <= abs(temp1);i++)
                        {
                            if((temp2 % i == 0) && (temp1 % i == 0))
                            {
                                temp2 = temp2 / i;
                                temp1 = temp1 / i;
                            }
                        }
                    }
                    else
                    {
                        for(int i2 = 2;i2 <= abs(temp2);i2++)
                        {
                            if((temp2 % i2 == 0) && (temp1 % i2 == 0))
                            {
                                temp2 = temp2 / i2;
                                temp1 = temp1 / i2;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            temp3 = numerator * denomonator2;
            temp4 = denomonator * denomonator2;
            temp1 = numerator2 * denomonator;
            temp2 = denomonator2 * denomonator;
            temp1 = temp1 + temp3;
            if(temp2 == temp1)
            {
                printf("Your fraction result is equal to 1(Specific: %d / %d)\n",temp1,temp2);
            }
            else
            {
                if((temp1 % temp2 == 0) || (temp2 % temp1 == 0))
                {
                    if(temp1 % temp2 == 0)
                    {
                        temp1 = temp1 / temp2;
                        temp2 = 1;
                    }
                    else
                    {
                        temp2 = temp2 / temp1;
                        temp1 = 1;
                    }
                }
                else
                {
                    if(temp2 > temp1)
                    {
                        for(int j = 2;j <= abs(temp1);j++)
                        {
                            if((temp2 % j == 0) && (temp1 % j == 0))
                            {
                                temp2 = temp2 / j;
                                temp1 = temp1 / j;
                            }
                        }
                    }
                    else
                    {
                        for(int j2 = 2;j2 <= abs(temp2);j2++)
                        {
                            if((temp2 % j2 == 0) && (temp1 % j2 == 0))
                            {
                                temp2 = temp2 / j2;
                                temp1 = temp1 / j2;
                            }
                        }
                    }
                }
            }
        }
        if(abs(temp1) > temp2)
        {
            if(temp1 < temp2)
            {
                goto bead:
            }
            else
            {
                printf("Your added fraction is: {%d %d / %d}\n",temp1 / temp2, abs(temp1 % temp2), temp2);
            }
        }
        else
        {
            bead:
            if(temp1 < 0)
            {
                if(temp2 < 0)
                {
                    printf("Your added fraction is: {%d / %d}\n",abs(temp1),abs(temp2));
                }
                else
                {
                    printf("Your added fraction is: {- %d / %d}\n",abs(temp1),temp2);
                }
            }
            else
            {
                printf("Your added fraction is: {%d / %d}\n",temp1, temp2);
            }
        }
    }
    if(action_function == 2)
    {
        if(denomonator2 == denomonator)
        {
            temp1 = numerator - numerator2;
            temp2 = denomonator;
            if(temp2 == temp1)
            {
                printf("Your fraction result is equal to 1(Specific: %d / %d)\n",temp1,temp2);
            }
            else
            {
                if((temp1 % temp2 == 0) || (temp2 % temp1 == 0))
                {
                    if(temp1 % temp2 == 0)
                    {
                        temp1 = temp1 / temp2;
                        temp2 = 1;
                    }
                    else
                    {
                        temp2 = temp2 / temp1;
                        temp1 = 1;
                    }
                }
                else
                {
                    if(temp2 > temp1)
                    {
                        for(int k = 2;k <= abs(temp1);k++)
                        {
                            if((temp2 % k == 0) && (temp1 % k == 0))
                            {
                                temp2 = temp2 / k;
                                temp1 = temp1 / k;
                            }
                        }
                    }
                    else
                    {
                        for(int k2 = 2;k2 <= abs(temp2);k2++)
                        {
                            if((temp2 % k2 == 0) && (temp1 % k2 == 0))
                            {
                                temp2 = temp2 / k2;
                                temp1 = temp1 / k2;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            temp3 = numerator * denomonator2;
            temp4 = denomonator * denomonator2;
            temp1 = numerator2 * denomonator;
            temp2 = temp4;
            temp1 = temp3 - temp1;
            if(temp2 == temp1)
            {
                printf("Your fraction result is equal to 1(Specific: %d / %d)\n",temp1,temp2);
            }
            else
            {
                if((temp1 % temp2 == 0) || (temp2 % temp1 == 0))
                {
                    if(temp1 % temp2 == 0)
                    {
                        temp1 = temp1 / temp2;
                        temp2 = 1;
                    }
                    else
                    {
                        temp2 = temp2 / temp1;
                        temp1 = 1;
                    }
                }
                else
                {
                    if(temp2 > temp1)
                    {
                        for(int l = 2;l <= abs(temp1);l++)
                        {
                            if((temp2 % l == 0) && (temp1 % l == 0))
                            {
                                temp2 = temp2 / l;
                                temp1 = temp1 / l;
                            }
                        }
                    }
                    else
                    {
                        for(int l2 = 2;l2 <= abs(temp2);l2++)
                        {
                            if((temp2 % l2 == 0) && (temp1 % l2 == 0))
                            {
                                temp2 = temp2 / l2;
                                temp1 = temp1 / l2;
                            }
                        }
                    }
                }
            }
        }
        if(abs(temp1) > temp2)
        {
            if(temp1 < temp2)
            {
                goto mead;
            }
            else
            {
                printf("Your subtracted fraction is: {%d %d / %d}\n",temp1 / temp2, abs(temp1 % temp2), temp2);
            }
        }
        else
        {
            mead:
            if(temp1 < 0)
            {
                if(temp2 < 0)
                {
                    printf("Your subtracted fraction is: {%d / %d}\n",abs(temp1),abs(temp2));
                }
                else
                {
                    printf("Your subtracted fraction is: {- %d / %d}\n",abs(temp1),temp2);
                }
            }
            else
            {
                printf("Your subtracted fraction is: {%d / %d}\n",temp1, temp2);
            }
        }   
    }
    else if(action_function == 3)
    {
        temp1 = numerator * numerator2;
        temp2 = denomonator * denomonator2;
        if(temp1 == temp2)
        {
            printf("Your multiplied fraction is equal to 1(Specific: %d / %d)\n",temp1,temp2);
        }
        else
        {
            if(temp1 < temp2)
            {
                for(int u = 2;u < temp1;u++)
                {
                    if((temp1 % u == 0) && (temp2 % u == 0))
                    {
                        temp1 = temp1 / u;
                        temp2 = temp2 / u;
                    }
                }
            }
            else
            {
                for(int u2 = 2;u2 < temp2;u2++)
                {
                    if((temp2 % u2 == 0) && (temp1 % u2 == 0))
                    {
                        temp2 = temp2 / u2;
                        temp1 = temp1 / u2;
                    }
                }
            }
        }
        if(abs(temp1) > temp2)
        {
            if(temp1 < temp2)
            {
                goto xead;
            }
            else
            {
                printf("Your multiplied fraction is: {%d %d / %d}\n",temp1 / temp2, abs(temp1 % temp2), temp2);
            }
        }
        else
        {
            xead:
            if(temp1 < 0)
            {
                if(temp2 < 0)
                {
                    printf("Your multiplied fraction is: {%d / %d}\n",abs(temp1),abs(temp2));
                }
                else
                {
                    printf("Your multiplied fraction is: {- %d / %d}\n",abs(temp1),temp2);
                }
            }
            else
            {
                printf("Your multiplied fraction is: {%d / %d}\n",temp1, temp2);
            }
        } 
    }
    else
    {
        temp1 = numerator;
        temp2 = denomonator;
        temp3 = denomonator2;
        temp4 = numerator2;
        temp1 = temp1 * temp3;
        temp2 = temp2 * temp4;
        if(temp1 == temp2)
        {
            printf("Your divided fraction is equal to 1(Specific: %d / %d)\n",temp1,temp2);
        }
        else
        {
            if(temp1 < temp2)
            {
                for(int u = 2;u < temp1;u++)
                {
                    if((temp1 % u == 0) && (temp2 % u == 0))
                    {
                        temp1 = temp1 / u;
                        temp2 = temp2 / u;
                    }
                }
            }
            else
            {
                for(int u2 = 2;u2 < temp2;u2++)
                {
                    if((temp2 % u2 == 0) && (temp1 % u2 == 0))
                    {
                        temp2 = temp2 / u2;
                        temp1 = temp1 / u2;
                    }
                }
            }
        }
        if(abs(temp1) > temp2)
        {
            if(temp1 < temp2)
            {
                goto zead;
            }
            else
            {
                printf("Your divided fraction is: {%d %d / %d}\n",temp1 / temp2, abs(temp1 % temp2), temp2);
            }
        }
        else
        {
            zead:
            if(temp1 < 0)
            {
                if(temp2 < 0)
                {
                    printf("Your divided fraction is: {%d / %d}\n",abs(temp1),abs(temp2));
                }
                else
                {
                    printf("Your divided fraction is: {- %d / %d}\n",abs(temp1),temp2);
                }
            }
            else
            {
                printf("Your divided fraction is: {%d / %d}\n",temp1, temp2);
            }
        } 
    }
    }
}