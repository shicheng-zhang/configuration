#include <stdio.h>
int main()
{
        int number, temp1, temp2;
        printf("Enter the length of your array:");
        scanf("%d",&number);
        int attr[number];
        char string[number];
        printf("Enter your string:");
        scanf("%s",string);
        for(int j = 0;j < number;j++)
        {
                attr[j] = string[j];
        }
        int shifter;
        printf("Enter your shifter:");
        scanf("%d",&shifter);
        for (int v = 0;v < number;v++)
        {
                if((attr[v] + shifter > 126) || (attr[v] + shifter < 33))
                {
                        if(attr[v] < 126)
                        {
                                temp1 = 126 - attr[v];
                                temp2 = shifter - temp1;
                                string[v] = (char)33 + temp2;
                        }
                        else
                        {
                                temp1 = attr[v] - 33;
                                temp2 = shifter + temp1;
                                string[v] = (char)126 - temp2;
                        }
                }
                else
                {
                        string[v] = attr[v] + shifter;
                }
        }
        printf("Your shifted array is: %s\n",string);
}
