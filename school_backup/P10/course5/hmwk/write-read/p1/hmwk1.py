def q1 ():
    file_op = open ("greetings.txt", "w+")
    file_op.write ("Hello! Welcome to Python file handling.\n")
def q2 ():
    file_op = open ("greetings.txt" , "r")
    print (file_op.read ())
    file_op.close ()
def q3 ():
    #Append lines first
    file_op = open ("greetings.txt", "a")
    file_op.write ("Have a great day!\n")
    file_op = open ("greetings.txt", "a")
    #Then read what was appended
    file_op.write ("Keep learning Python.\n")
    file_op = open ("greetings.txt", "r")
    print (file_op.read ())
    file_op.close ()
def q4 ():
    file_op = open ("greetings.txt", "r")
    for x in range (3):
        #Open the file and read lines from it
        print (file_op.readline ())
    file_op.close ()
def q5 ():
    list_names = []
    for y in range (5):
        list_names += [1] #Add naems to a pre-defined list
        list_names [y] = (str) (input ("Enter a name:"))
    file_op = open ("names.txt", "a")
    for z in range (5):
        #Write names from list to file
        file_op.write ("%s\n" % list_names [z])
    file_op.close ()
q1 ()
q2 ()
q3 ()
q4 ()
q5 ()
