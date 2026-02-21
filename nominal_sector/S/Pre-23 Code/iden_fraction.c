/* March 11th, 2023
# 
# This is a C program intended to be used as a calculator for determining fractions that can 
# be simplified in any extent under any positive inputted denomonator, please note that this 
# program does not extend this function towards negative denomonators, and inputting a nega-
# tive denomonator will result in the program automatically exiting without any output of r-
# esults.
#
# Please do not directly copy and paste this program onto any other program without direct 
# reference, doing so without reference is plagiarism.
#
# Program Example: Denomonator input = 78;
# 2 over 78, or 2/78 is a may-simplified fraction.... : Output for divisible fraction
# Awaiting next dividible fraction, the current comparision is undividible.: Output for undivisible fraction.
#
# Copyright 2023, Shicheng.Z     
#*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
	int denomonator;
	char str;
	head:
	printf("Initiate System?(y/n):");
	scanf("%c",&str);
	char str2 = 'y';
	char str3 = 'n';
	if((str != str3)&&(str == str2))
	{
		printf("Enter your denomonator:");
		scanf("%d",&denomonator);
		if(denomonator==1)
		{
			printf("All fractions with denomonator 1 are undividible.\n");
			exit(0);
		}
		int y=1;
		for(int i=1;i<=denomonator;i++)
		{
			int v=0;
			for(int p=1;p<=i&&p<=denomonator;p++)
			{
				if((i>p)||(i==p))
				{
					if(((i%p==0)&&(denomonator%p==0))||((denomonator%i==0)||(i%denomonator==0)))
					{
						v++;
					}
					else
					{
						continue;
					}
				}
				else if(i<p) 
				{
					if(((denomonator%p==0)&&(denomonator%i==0))||((denomonator%i==0)||(i%denomonator==0)))
					{
						v++;
					}	
					else
					{
						continue;
					}
				}
				else
				{
					printf("Please check input denomonator, then try again.\n");
					sleep(1);
					goto head;
				}
			}		
			if((v!=0)&&(v!=1))
			{
				printf("%d data process complete.\n",y);
				printf("%d over %d, or %d/%d, is a may-simplyfied fraction with denomonator %d.\n",i,denomonator,i,denomonator,denomonator);
				y++;
			}
			else
			{
				printf("Awaiting next dividible fraction, the current comparision is undividible.\n");
			}
		}
	}
	else if((str != str2)&&(str == str3))
	{
		printf("Program terminated.\n");
		exit(0);
	}
	else
	{
		printf("Please check your decision, then try again.\n");
		goto head;
	}
	return 1;
}
