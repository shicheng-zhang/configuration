def q2 (r, c):
    #Complete
    list_out = [[(x + 1) + (y * (r + 1)) for x in range (c)] for y in range (r)]
    return list_out
def q2_2 (r, c):
    #Complete
    list_out = [[(str) (y) + (str) (x) for x in range (c)] for y in range (r)]
    return list_out
def q3 (lists):
    #Complete
    new_list = [y for x in lists for y in x]
    return new_list
def outofbounds (list2, x, y):
    #q4 - Complete
    #x is the elements of list2
    #y is the elements of list2 [x]
    if x < len (list2) and x >= -1:
        if y < len (list2 [x]) and y >= -1:
            return True
        else:
            return False
    else:
        return False
    return
print (q2 (4, 5))
