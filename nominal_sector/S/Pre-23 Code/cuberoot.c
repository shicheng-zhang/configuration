/*This is a C program designed to be a cube root approximator for all purposes.
 * Note that this program cannot determine a exact cube root and please use the 
 * exact cube root calculator for those purposes. This program uses the exact 
 * same principle of approximating the distance to perfect cubes on a numberline
 * to determine the fractional proportion as the square root calculator earlier,
 * and this program runs on the same kind of algorithm derived from that logic.
 * 
 * Note that due to its algorithm's nature, this program also has higher margins
 * than the square root program, and may lead to erronous results,it is strongly
 * advised for smaller values to back up this approximation with an actual calculation
 * from a precise cube root calculator for better results, especially for values 
 * below 100. For negative numbers and 0, the program just returns the value that
 * you inputted, and mixed number inputs return the approx cube root of a randomly
 * generated number or just -inf.
 *
 * Don't even try to copy and paste it >:(
 *
 * 18th March, 2023.  Shicheng.Z
 */
#include <stdio.h>
#include <stdlib.h>
int main()
{
        int number;
        printf("Enter any whole number:");
        scanf("%d",&number);
        int h = 1;
        int larger, smaller, larger2, smaller2;
        while (1)
        {
                if((h * h * h) == number)
                {
                        printf("The cube root of %d = %d\n",number,h);
                        exit(0);
                }
                else
                {
                        if((h * h * h) > number)
                        {
                                larger = h;
                                smaller = h - 1;
                                larger2 = h * h * h;
                                smaller2 = (h - 1) * (h - 1) * (h - 1);
                                break;
                        }
                        else
                        {
                                h = h + 1;
                        }
                }
        }
        float diff = number - smaller2;
        float diff2 = larger2 - number;
        float fraction = diff / (diff + diff2);
        float result = (float)smaller + fraction;
        printf("The cube root of %d = %f\n",number,result);
}
