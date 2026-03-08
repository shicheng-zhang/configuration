/*This is a C program that calculates the approximate square root of 
# a number via a new algorithm devised by writer(see below). This al-
# gorithm/program is not intended for exact square root calculations
# such as used in calculus and also in other mathematical situations
# that require an exact square root output as this is just a close 
# approximation. The result outputted will nearly always be lower than
# the actual square root, and deviations will be between 0.1~0.000001.
# If you happen to find a number that has no deviation in the 6 decimal
# digits outputted, please comment below the program and write the nu-
# mber down in the comments :)
#
# The algorithm used is a new algorithm that uses the two perfect sq-
# uares which are closest to the number in question, then, using the
# difference between the perfect squares and the original input, a 
# fraction is created from that difference, which is combined with
# the square root of the smaller perfect square for the approximate
# square root calculation of the value "number".
#
# For example, if we enter the value 67:
# The While loop determines that the perfect squares closest to 67 are
# 64 and 81, then, the logic goes like this.
#
# 64-------67--------81
# 
# Then, the if((h * h) > number) section also gives us this line:
#
# sqrt(64) = 8 -----sqrt(67)--------sqrt(81) = 9
#
# Then, the ration of the whole numbbers are calculated using this formula:
#
# 64-------------67----------------81
# diff = 67-64=3   diff2 = 81-67=14
# 
# This part is represented by the float diff = number - smaller2 and the 
# float diff2 = larger2 - number section.
# 
# Then, using this ratio, we can determine that a good guess of the decimal
# section of the square root of 67 can be done by using the same ratio, wh-
# ich can be calculated by diff / (diff + diff2)*, which gives us the equation
# 3 / (3 + 14) or 3 / 17, or ~0.176470, as represented by the: 
# float fraction = diff / (diff + diff2)
#
# 64-------------67---------------81
#   diff = 3         diff2 = 14
#        total diff = 17
# 
# *: The total amount of "steps" in the diff/diff2 section, given by: 
# diff + diff2.
#
# Now, all that remains is to add the smaller perfect square root
# (as 67 if smaller than 81), to the decimal section of the square root,
# which gives us the values:
# 
# Approximated square root: ~8.176470
# Actual square root: ~8.185352
# Diff: 0.008882
# Still a very good approximation of the actual answer!
#
# This program cannot handle negative inputs and returns the input upon the input
# of a negative number. as for non-integer inputs, results may vary from -inf to
# outputs of the square roots of the numerical versions of the non-integer input,
# which may be faulty to the value that the user is seeking.
#
# Please do not copy and paste the program and please give credit if you do >:(
#
# 16th March, 2023.  Shicheng.Z
*/
#include <stdio.h>
#include <stdlib.h>
int main()
{
        int number;
        printf("Enter any whole number:");
        scanf("%d",&number);
        int h = 1;
        int larger, smaller, larger2, smaller2;
        while (1)
        {
                if((h * h) == number)
                {
                        printf("The square root of %d = %d\n",number,h);
                        exit(0);
                }
                else
                {
                        if((h * h) > number)
                        {
                                larger = h;
                                smaller = h - 1;
                                larger2 = h * h;
                                smaller2 = (h - 1) * (h - 1);
                                break;
                        }
                        else
                        {
                                h = h + 1;
                        }
                }
        }
        float diff = number - smaller2;
        float diff2 = larger2 - number;
        float fraction = diff / (diff + diff2);
        float result = (float)smaller + fraction;
        printf("The square root of %d = %f\n",number,result);
}
