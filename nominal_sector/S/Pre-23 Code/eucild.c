#include <stdio.h>
int main()
{
	int input1, input2;
	printf("Enter input 1:");
	scanf("%d",&input1);
	printf("Enter input 2:");
	scanf("%d",&input2);
	int temp1 = 1, temp2;
	int temp3 = input1;
	int temp4 = input2; 
	while (1)
	{
		temp1 = input1 / input2;
		temp2 = input1 % input2;
		if(temp2 == 0)
		{
			temp1 = input2;
			break;
		}
		else
		{
			input1 = input2;
			input2 = temp2;
		}
	}
	printf("The GCD of {%d, %d} = %d\n",temp3,temp4,temp1);
}
