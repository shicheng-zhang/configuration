def method_1 (one, two, three, four, five):
    return one * two * three * four * five
def method_2 (list_args):
    output = 1
    for y in range (len (list_args)):
        output *= list_args [y]
    return output
def method_3 (*arguments):
    output = 1
    for z in arguments:
        output *= z
    return output
num_variables = 5
print (method_1 (1, 2, 3, 4, 5))
array = [1, 2, 3, 4, 5]
print (method_2 (array))
print (method_3 (1, 2, 3, 4, 5))

