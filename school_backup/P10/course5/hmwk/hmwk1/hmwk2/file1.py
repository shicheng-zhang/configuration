def longest_word ():
    filein = open ("A1Q1.txt", "r")
    lines = filein.readlines ()
    print_count = ""
    size = 0
    for line in lines:
        if len (line) > size:
            print_count = line
    print (print_count)
    filein.close ()
def read_last_n_lines (start_line):
    filein2 = open ("A1Q2.txt", "r")
    lines = filein2.readlines ()
    len_lines = len (lines)
    start_line = len_lines - start_line - 1
    count_line = 0
    for line in lines:
        if count_line >= start_line:
            print (line, end = "")
        count_line += 1
    filein2.close ()
def count_names ():
    name_list = open ("A1Q3.txt", "r")
    lines = name_list.readlines ()
    names = []
    count = 0
    for line in lines:
        names += [line.rstrip ("\n")] 
    names2 = []
    count_names = []
    for x in names:
        if x.lower () not in names2:
            if x.lower () == "\n":
                names2 += ["\\n"]
                count_names += [1]
            else:
                names2 += [x.lower ()] 
                count_names += [1]
        else:
            for y in range (len (names2)):
                if x.lower () == names2 [y]:
                    count_names [y] += 1
                    break
    maximum = 0
    setattr_val = 0
    attr = 0
    for b in count_names:
        if b > maximum:
            maximum = b
            setattr_val = attr
        attr += 1
    print ("The most reoccuring value is", names2 [setattr_val], "occuring", count_names [setattr_val], "times.")
def productandprice ():
    product_file = open ("products.txt", "r")
    products = product_file.readlines ()
    price_file = open ("prices.txt", "r")
    prices = price_file.readlines ()
    expensive = 0
    for c in range (len (prices)):
        if (float) (prices [c].strip ()) > expensive:
            expensive = c
        print (products [c].rstrip ("\n"), ": $", prices [c])
    print ("The most costly thing is", products [expensive].rstrip ("\n"), "with a price of $", prices [expensive])
