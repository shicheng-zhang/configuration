#include <stdio.h>
#include <unistd.h>
int factor(int q);
int factor(int q)
{
        int result = 2;
        int transmitter;
        int carrier = 0;
        for(int y = 2;y < q;y++)
        {
                if(q % y == 0)
                {
                        result++;
                        transmitter = y;
                }
        }
        if(result == 2)
        {
                return carrier;
        }
        else
        {
                return transmitter;
        }
}
int main()
{
        int attr[9];
        sleep(4);
        printf("System interupt...online.// Driver 004123653 REC:PRO:0:INI:> <Matrix System Trace>.\n");
        sleep(4);
        printf("System Initiate.....\n");
        sleep(4);
        printf("DISK://C:// alter.llibt.....\n");
        sleep(4);
        printf("DISK INITIATING....\n");
        sleep(4);
        printf("Drivers Check//: Input REC:LOG/INPUT system, reallocation devices active....\n");
        sleep(4);
        printf("Call Transfer opt: recived. 05-03-23. REC:/log>\n");
        sleep(4);
        printf("Trace program: running\n");
        sleep(4);
        for(int r = 0;r < 9;r++)
        {
                printf("Enter attribute:");
                scanf("%d",&attr[r]);
        }
        int temp;
        int j = 0, f = 0, gvl = 0;
        int attr2[3], attr3[3], attr4[3], attr5[3], attr6[3], attr7[3];
        for(int i = 0;i < 3;i++)
        {
                attr2[i] = attr[i];
                printf("%d ",attr2[i]);
        }
        printf("\n");
        for(int w = 3;w < 6;w++)
        {
                attr3[j] = attr[w];
                printf("%d ",attr3[j]);
                j++;
        }
        printf("\n");
        j = 0;
        for(int c = 6;c < 9;c++)
        {
                attr4[j] = attr[c];
                printf("%d ",attr4[j]);
                j++;
        }
        printf("\n\n");
        for(int h = 0;h < 3;h++)
        {
                for(int q = 0;q < 3;q++)
                {
                        if(attr2[h] > attr2[q])
                        {
                                temp = attr2[h];
                                attr2[h] = attr2[q];
                                attr2[q] = temp;
                        }
                }
        }
        for(int d8 = 0;d8 < 3;d8++)
        {
                for(int n = 0;n < 3;n++)
                {
                        if(attr3[d8] > attr3[n])
                        {
                                temp = attr3[d8];
                                attr3[d8] = attr3[n];
                                attr3[n] = temp;
                        }
                }
        }
        for(int g2 = 0;g2 < 3;g2++)
        {
                for(int p1 = 0;p1 < 3;p1++)
                {
                        if(attr4[g2] > attr4[p1])
                        {
                                temp = attr4[g2];
                                attr4[g2] = attr4[p1];
                                attr4[p1] = temp;
                        }
                }
        }
        for(int g1 = 0;g1 < 3;g1++)
        {
                attr[g1] = attr2[g1];
                printf("%d ",attr2[g1]);
        }
        printf("\n");
        for(int zx = 3;zx < 6;zx++)
        {
                attr[zx] = attr3[gvl];
                printf("%d ",attr3[gvl]);
                gvl++;
        }
        gvl = 0;
        printf("\n");
        for(int b = 6;b < 9;b++)
        {
                attr[b] = attr4[gvl];
                printf("%d ",attr4[gvl]);
                gvl++;
        }
        printf("\n\n");
        for(int d = 0;d < 3;d++)
        {
                attr5[d] = attr[f];
                printf("%d ",attr5[d]);
                f = f + 3;
        }
        f = 1;
        printf("\n");
        for(int s = 0;s < 3;s++)
        {
                attr6[s] = attr[f];
                printf("%d ",attr6[s]);
                f = f + 3;
        }
        f = 2;
        printf("\n");
        for(int a = 0;a < 3;a++)
        {
                attr7[a] = attr[f];
                printf("%d ",attr7[a]);
                f = f + 3;
        }
        printf("\n\n");
        for(int r1 = 0;r1 < 3;r1++)        {
                for(int p1 = 0;p1 < 3;p1++)
                {
                        if(attr5[r1] > attr5[p1])
                        {
                                temp = attr5[r1];
                                attr5[r1] = attr5[p1];
                                attr5[p1] = temp;
                        }
                }
        }
        for(int q3 = 0;q3 < 3;q3++)
        {
                for(int p2 = 0;p2 < 3;p2++)
                {
                        if(attr6[q3] > attr6[p2])
                        {
                                temp = attr6[q3];
                                attr6[q3] = attr6[p2];
                                attr6[p2] = temp;
                        }
                }
        }
        for(int s11 = 0;s11 < 3;s11++)
        {
                for(int p3 = 0;p3 < 3;p3++)
                {
                        if(attr7[s11] > attr7[p3])
                        {
                                temp = attr7[s11];
                                attr7[s11] = attr7[p3];
                                attr7[p3] = temp;
                        }
                }
        }
        int gh = 0,rf = 1,nj = 2;
        for(int q2 = 0;q2 < 3;q2++)
        {
                attr[gh] = attr5[q2];
                gh = gh + 3;
        }
        for(int kf = 0;kf < 3;kf++)
        {
                attr[rf] = attr6[kf];
                rf = rf + 3;
        }
        for(int dv = 0;dv < 3;dv++)
        {
                attr[nj] = attr7[dv];
                nj = nj + 3;
        }
        for(int f4 = 0;f4 < 3;f4++)
        {
                printf("%d ",attr5[f4]);
                printf("%d ",attr6[f4]);
                printf("%d ",attr7[f4]);
                printf("\n");
        }
        printf("\n");
        for(int sc5 = 0;sc5 < 9;sc5++)
        {
                attr[sc5] = factor(attr[sc5]);
        }
        int ss = 0,aa = 1,ww = 2;
        for(int wd4 = 0;wd4 < 3;wd4++)
        {
                printf("%d ",attr[ss]);
                printf("%d ",attr[aa]);
                printf("%d ",attr[ww]);
                ss = ss + 3;
                aa = aa + 3;
                ww = ww + 3;
                printf("\n");
        }
        printf("\n");
        printf("The Trace Code:");
        for(int ew = 0;ew < 9;ew++)
        {
                if(attr[ew] != 0)
                {
                        printf("%d ",attr[ew]);
                }
        }
        printf(".");
        printf("\n");
        printf("\n");
}

