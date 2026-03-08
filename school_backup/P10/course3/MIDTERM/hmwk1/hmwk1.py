def return_largest_element (listos, size_list):
    largest = 0
    for x in range (size_list):
        if largest < listos [x]:
            largest = listos [x]
    return largest
def find_pos (list_q, add_element):
    length = 0
    return_val = -1
    for y in list_q:
        length += 1
    for z in range (length):
        if list_q [z] == add_element:
            return_val = z
    return return_val
def palindrome (string):
    length = 0
    for a in string:
        length += 1
    decider = 1
    if length % 2 == 0:
        count_size = length // 2
        for c in range (count_size):
            if string [c] != string [(length - 1) - c]:
                decider = 0
    else:
        count_size = (length - 1) // 2
        for b in range (count_size):
            if string [b] != string [(length - 1) - b]:
                decider = 0
    if decider == 1:
        return True
    elif decider == 0:
        return False
    else:
        return
def rotate (list_in, rot_amt):
    for c in range (rot_amt):
        list_in.insert (0, list_in.pop ())
    return list_in
def bubblesort (list_sort):
    sizelist = 0
    for f in list_sort:
        sizelist += 1
    for g in range (sizelist):
        for h in range (sizelist):
            if list_sort [g] < list_sort [h]:
                list_sort [g], list_sort [h] = list_sort [h], list_sort [g]
    return list_sort
def print_string (list_words):
    length = 0
    for i in list_words:
        length += 1
    max_len_word = 0
    iterative_max = 0
    for j in range (length):
        for k in list_words [j]:
            iterative_max += 1
        if iterative_max > max_len_word:
            max_len_word = iterative_max
        iterative_max = 0
    for l in range (max_len_word + 2):
        print ("*", end = "")
    print ("")
    for m in range (length):
        print ("*", end = "")
        size_concurrent = 0
        for n in list_words [m]:
            size_concurrent += 1
        print (list_words [m], end = "")
        if size_concurrent != max_len_word:
            for o in range (max_len_word - size_concurrent):
                print (" ", end = "")
        print ("*")
    for p in range (max_len_word + 2):
        print ("*", end = "")
    print ("")
list_wds = ["Lucien", "Is", "Poopy"]
print_string (list_wds)

