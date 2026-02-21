#include <stdio.h>
int power(int base, int exponent);
int largest(int number, int number2);
int power(int base, int exponent)
{
	int base2 = 1;
	if(exponent == 0)
	{
		return base;
	}
	base2 = base;
	for(int uu = 0;uu < exponent - 1;uu++)
	{	
		base2 = base * base2;
	}
	return base2;
}
int largest(int number, int number2)
{
	if(number == number2)
	{
		return number;
	}
	else if(number < number2)
	{
		return number2;
	}	
	else
	{
		return number;
	}
}
int main()
{
	int number, number2;
	printf("Enter your first number:");
	scanf("%d",&number);
	printf("Enter your second number:");
	scanf("%d",&number2);
	int spare = largest(number, number2);
	int attr[spare], attr2[spare], attr3[spare], attr4[spare];
	for(int a = 0;a < spare;a++)
	{
		attr[a] = 0;
	}
	for(int aa = 0;aa < spare;aa++)
	{
		attr2[aa] = 0;
	}
	for(int aaa = 0;aaa < spare;aaa++)
	{
		attr3[aaa] = 0;
	}
	for(int aaaa = 0;aaaa < spare;aaaa++)
	{
		attr4[aaaa] = 0;
	}
	int def = 0, def2 = 0, def3 = 0, def4 = 0, plus = 0, plus2 = 0, plus3 = 0;
	//Convert Entries into binary numbers.
	while (1)
	{
		if (def == 1)
		{
			break;
		}
		else
		{
			if (number == 1)
			{
				def = 1;
			}
			attr[plus] = number % 2;
			number = number / 2;
		}
		plus = plus + 1;
	}
	while (1)
	{
		if (def2 == 1)
		{
			break;
		}
		else
		{
			if (number2 == 1)
			{
				def2 = 1;
			}
			attr2[plus2] = number2 % 2;
			number2 = number2 / 2;
		}
		;
		plus2 = plus2 + 1;
	}
	//Do the XOR calculation.
	for(int sxsx = 0;sxsx < spare;sxsx++)
	{
		if(attr[sxsx] == attr2[sxsx])
		{
			attr3[sxsx] = 0;
		}
		else
		{
			attr3[sxsx] = 1;
		}
	}
	//Reconfigure converted binary to decimal.
	attr4[0] = attr3[0] * 1;
	for(int sks = 1;sks < spare;sks++)
	{
		attr4[sks] = attr3[sks] * power(2, sks);
	}
	int result = 0;
	for(int sks1 = 0;sks1 < spare;sks1++)
	{
		result = result + attr4[sks1];
	}	
	printf("%d\n",result);
}
