def find_largest_element (array):
    largest = 0
    for x in array:
        for y in x:
            if y > largest:
                largest = y
    return largest
def sum_vector (array):
    summ = 0
    for z in array:
        for a in z:
            summ = summ + a
    return summ
def q1 ():
    matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print (matrix [1])
def q2 ():
    grid = [[2, 3, 4], [5, 6, 7], [8, 9, 10]]
    total = 0
    for xx in grid:
        for yy in xx:
            total += yy
    print (total)
def q3 ():
    matrix2 = [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]]
    print (matrix2 [2][1])
def q4 ():
    matrix_i = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    matrix_e = [[0 for b in range (3)] for c in range (3)]
    for zz in range (3):
        for aa in range (3):
            matrix_e [zz][aa] = matrix_i [aa][zz]
    print (matrix_e)




