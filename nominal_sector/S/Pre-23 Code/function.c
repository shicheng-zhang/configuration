#include <stdio.h>
int first_func(float number);
int second_func(float snumber);
int third_func(float tnumber);
int first_func(float number)
{
        float new_number = (number * number) + (1 / number);
        return new_number;
}
int second_func(float snumber)
{
        float new_num = snumber * snumber + 1;
        return new_num;
}
int third_func(float tnumber)
{
        float newnum = 1 / (tnumber + 1);
        return newnum;
}
int main()
{
        float number, number2;
        head:
        printf("Enter a number:");
        scanf("%f",&number);
        printf("Enter another number:");
        scanf("%f",&number2);
        float end;
        if(number > number2)
        {
                printf("Reinput.\n");
                goto head;
        }
        else
        {
                end = first_func(number) + second_func(number) + third_func(number) + first_func(number2) + second_func(number2) + third_func(number2); 
        }
        printf("result = %f\n",end);
}