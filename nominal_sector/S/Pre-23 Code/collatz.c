#include <stdio.h>
#include <stdlib.h>
int collatz(int number);
int collatz(int number)
{
        if(number % 2 == 0)
        {
                number = number / 2;
                printf("%d\n",number);
                exit(0);
        }
        else if(number % 2 != 0)
        {
                number = number * 3 + 1;
                printf("%d\n",number);
                exit(0);
        }
        else
        {
                ;

        }
}
int main()
{
        int number;
        printf("Enter number:");
        scanf("%d",&number);
        collatz(number);
}
