/* This is a C program designed to be a basic replication of the Nazi Enigma 
 * Encoding and decoding machine for sending messages. Unlike the real enigma,
 * this program(at current) does not have the 1.65 quintillion possibilities
 * that the original enigma possesses. 
 *
 * The main Algorithm/Logic used at the original publication on the 22nd of
 * March 2023 converts the inputted numbers(substitute for letters) into five 
 * series of numbers/letters that are outputted, which is the numbers' encrypted 
 * form. The first line prints 1 for a composite number, or 0 for a prime number.
 * The second line prints the prime numbers as the prime number plus the scrambler
 * number(see code below), and displays the composite numbers as 0. The third line 
 * prints the exact same values, but the prime number + scrambler values are now
 * in their symbol/letter form. The fourth line prints the smallest factors of the
 * composite numbers in their place, and prints 0 for the prime number places, while
 * the last line prints the factor which are needed to multiply with the fourth line
 * counterparts in order to equal the input number of the same attribute in the 
 * original/originally inputted array.
 * 
 * This is only the baby version of my recreation of the new enigma machine, several 
 * will follow to increase the complexity and security of the new code. If you really
 * to use this program in your programs, please leave a reference to me and if you find
 * anything wrong with the input of certain values, please notify me. Entering certain 
 * values such as negative numbers may trigger segmentaion fault or flaoting point exception
 * on your devices, or simply just output the scrambler as 0 in some bizzare cases.
 *
 * Example code:
 *
 * helloworld as input:
 * Attribute Size Def: 10
 * Values: 104, 101, 108, 108, 111, 119, 111, 114, 108, 100
 * (number values of: h, e, l, l, o, w, o, r, l, d)
 * Output:
 *	1 - 0 - 1 - 1 - 1 - 1 - 1 - 1 - 1 - 1 -
 *      0 - 103 - 0 - 0 - 0 - 0 - 0 - 0 - 0 - 0 -
 *	0 - g - 0 - 0 - 0 - 0 - 0 - 0 - 0 - 0 -
 *	2 - 0 - 2 - 2 - 3 - 7 - 3 - 2 - 2 - 2 -
 *	52 - 0 - 54 - 54 - 37 - 17 - 37 - 57 - 54 - 50 -
 *	Scrambler = 2
 *
 * 22nd March, 2023.  Shicheng.Z
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int prime(int l);
int smallest_factor(int s);
int prime(int l)
{
        int j = 0;
        if((l == 0) || (l == 1) || (l < 0) || (l == 2))
        {
                return j;  
        }
        else
        {
                for(int g = 1;g <= l;g++)
                {
                        if((l % g) == 0)
                        {
                                j++;
                        }
                }
        }
        ;
        if(j == 2)
        {
                j = 0;
        }
        return j;
}
int smallest_factor(int s)
{
        int smallest;
        for(int h = s;h >= 2;h--)
        {
                if(s % h == 0)
                {
                        smallest = h;
                }
        }
        return smallest;
}
int main()
{
        int number;
        printf("Enter any number:");
        scanf("%d",&number);
        char string[number];
        int attr[number];
        int attr2[number];
        int attr3[number];
        int attr4[number];
        int attr5[number];
        int scrambler;
        printf("Welcome to the new Enigma Machine.\n");
	sleep(2);
        printf("Enter string:");
        scanf("%s",string);
        
        for(int bbb = 0;bbb < number;bbb++)
        {
                attr[bbb] = string[bbb];
        }
        printf("Enter the scramble number:");
        scanf("%d",&scrambler);
        for(int h7 = 0;h7 < number;h7++)
        {
                attr5[h7] = attr[h7];
        }
        for(int h1 = 0;h1 < number;h1++)
        {
                attr2[h1] = 0;
        }
        for(int h2 = 0;h2 < number;h2++)
        {
                attr3[h2] = 0;
        }
        for(int h3 = 0;h3 < number;h3++)
        {
                attr4[h3] = 0;
        }
        int e = 0;
        while (1)
        {
                if(e == number)
                {
                        break;
                }
                else
                {
                        if(prime(attr[e]) == 0)
                        {
                                attr2[e] = attr[e];
                                attr[e] = 0;
                        }
                        else
                        {
                                attr3[e] = smallest_factor(attr[e]);
                                attr4[e] = attr[e] / attr3[e];        
                        }
                        e++;
                }
        }
        printf("\n");
        for(int a = 0;a < number;a++)
        {
                if(attr[a] == 0)
                {
                        printf("0 ");
                }
                else
                {
                        printf("1 ");
                }
        }
        printf("\n");
        for(int a5 = 0;a5 < number;a5++)
        {
                if(attr2[a5] == 0)
                {
                        printf("0 ");
                }
                else
                {
                        printf("%d ",attr2[a5] + scrambler);
                }
        }
        printf("\n");
        for(int a3 = 0;a3 < number;a3++)
        {
                printf("%d ",attr3[a3]);
        }
        printf("\n");
        for(int a4 = 0;a4 < number;a4++)
        {
                printf("%d ",attr4[a4]);
        }
        printf("\n");
        printf("%d\n\n",scrambler);
        for(int bb = 0;bb < number;bb++)
        {
                printf("%c",attr5[bb]);
        }
        printf("\n\n");
}
