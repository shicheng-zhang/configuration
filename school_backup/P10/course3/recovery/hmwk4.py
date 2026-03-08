def palindrome (string):
    string2 = string [::-1]
    if string2 == string:
        return True
    else:
        return False
    return
def crate (string):
    max_len_string = 0
    concurrent_len_string = 0
    for x in string:
        for y in x:
            concurrent_len_string += 1
        if max_len_string < concurrent_len_string:
            max_len_string = concurrent_len_string
        concurrent_len_string = 0
    for z in range (max_len_string):
        print ("*", end = "")
    print ("")
    for a in range (len (string)):
        print ("*", end = "")
        print (string [a], end = "")
        for b in range (max_len_string - len (string [a])):
            print (" ", end = "")
        print ("*")
    for b in range (max_len_string):
        print ("*", end = "")
    print ("")
string = ["Hello", "World", "This", "Is", "Very", "Poopy"]
crate (string)
