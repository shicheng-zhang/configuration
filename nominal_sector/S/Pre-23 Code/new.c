#include <stdio.h>
int Prime(int prime);
int Prime(int prime)
{
        int result=1;
        int y = 0;
        int e = 1;
        for(int f=1;f<prime;f++)
        {
                if(prime%f==0)
                {
                        result++;
                }
                else
                {
                        continue;
                }
        }
        if((result == 2)||(prime==1))
        {
                return y;
        }
        else
        {
                return e;
        }
}
int main()
{
        int attr[10],attr2[10],attr3[10],attr4[10],m = 0;
        for(int i = 0;i < 10;i++)
        {
                attr2[i] = 0;
                attr3[i] = 0;
                printf("Enter number:");
                scanf("%d",&attr[i]);
        }
        for(int h = 0;h < 10;h++)
        {
                m = attr[h] % 10;
                for(int q = 0;q < 10;q++)
                {
                        attr[h]--;
                        if(attr[h] % 10 == 0)
                        {
                                break;
                        }
                }
                attr[h] = attr[h] / 10;
                attr[h] = attr[h] + m;
                printf("%d\n",attr[h]);
        }
        int l;
        int d = 0;
        int cv = 0;
        for(int k = 0;k < 10;k++)
        {
                l = Prime(attr[k]);
                printf("P%d: %d, %d\n",l,attr[k],k);
                if(l == 0)
                {
                        attr2[d] = 0;
                        attr3[d] = 0;
                        d++;
                        continue;
                }
                else
                {
                        int w = attr[k] - 1;
                        cv = attr[k];
                        for(int s = 0;s < attr[k] - 1;s++)
                        {
                                if((attr[k] % w == 0)&&(attr[k] != cv)&&(attr[k] != 1)&&(w != 1))
                                {
                                        attr2[d] = w;
                                        attr3[d] = attr[k] / w;
                                        printf("{%d, %d}\n",w,attr[k] / w);
                                }
                                w--;
                        }
                        d++;
                }
        }
        for(int c = 0;c < 10;c++)
        {
                if((attr2[c] == 0)&&(attr3[c] == 0))
                {
                        attr4[c] = 0;
                }
                else
                {
                        attr2[c] = attr2[c] * 10;
                        attr4[c] = attr3[c] + attr2[c];
                }
        }
        printf("The Trace Factors are:\n");
        for(int hj = 0;hj < 10;hj++)
        {
                printf("%dst: %d\n",hj,attr4[hj]);
        }
}
