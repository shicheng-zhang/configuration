#include <stdio.h>
//Brute Force CPU Benchmark
int prime(long long number);
int prime(long long number)
{
	int result = 0;
	for(int y = 2;y < number;y++)
	{
		if(number % y == 0)
		{
			result = 1;
		}
	}
	return result;
}
int main()
{
	long long number;
	while (1)
	{
		if(prime(number) == 0)
		{
			printf("%c",(char)number);
		}
		else
		{
			if(number % 3 == 0)
			{
				printf("%llx",number);
			}
			else
			{
				printf("%lld",number);
			}
		}
		number++;
	}
}
