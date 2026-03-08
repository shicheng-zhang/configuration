#include <stdio.h>
#include <stdlib.h>
int digit_sum(int s);
int RAW_DIFF(int h, int k);
int prime(int l);
int smallest_factor(int s);
int digit_sum();
int RAW_DIFF(int h, int k)
{
        int result = 0;
        if(h == k)
        {
                return result;
        }
        else if(h < k)
        {
                return k - h;
        }
        else
        {
                return h - k;
        }
}
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
        int attr6[number];
        int attr7[number];
        int attr8[number];
        int scrambler;
        printf("Welcome to the new Enigma Machine.\n");
        printf("Warning: write any number containing 0 in letter format(ex: write 0 as zero, write 10000 as ten thousand).\n");
        printf("Enter string:");
        scanf("%s",string);
        for(int bbb = 0;bbb < number;bbb++)
        {
                attr[bbb] = string[bbb];
        }
        printf("Enter the scramble number:");
        scanf("%d",&scrambler);
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
        printf("\n\n\n");
        for(int h = 0;h < number;h++)
        {
                if(attr2[h] == 0)
                {
                        attr6[h] = 0;
                        attr8[h] = 0;
                }
                else
                {
                        attr6[h] = attr2[h] + 1 + scrambler;
                        attr8[h] = (attr2[h] + scrambler) - 1;
                } 
        }
        for(int h2 = 0;h2 < number;h2++)
        {
                if(attr3[h2] == 0)
                {
                        attr7[h2] = 0;
                        attr5[h2] = 0;
                }
                else
                {
                        attr7[h2] = attr3[h2] + attr4[h2] + scrambler;
                        attr5[h2] = RAW_DIFF(attr3[h2], attr4[h2]) + scrambler;
                } 
        }
        for(int j = 0;j < number;j++)
        {
                printf("%x ",attr6[j]);
        }
        printf("\n");
        for(int j1 = 0;j1 < number;j1++)
        {
                printf("%x ",attr7[j1]);
        }
        printf("\n");
        for(int j2 = 0;j2 < number;j2++)
        {
                printf("%x ",attr8[j2]);
        }
        printf("\n");
        for(int j3 = 0;j3 < number;j3++)
        {
                printf("%x ",attr5[j3]);
        }
        printf("\n\n\n");
}
