def todolist ():
    file = open ("todo.txt", "a")
    while True:
        writein = input ("What do you want to write:")
        if writein.lower () == "exit":
            break
        file.write (writein + "\n")
        print ("Text", writein, "written to file.")
def modifygrocery ():
    object_in = (str) (input ("Enter the fruit that you wish to input:"))
    it = 0
    breakpt = 1
    while True:
        if it != 0:
            if breakpt == 1:
                break
            else:
                breakpt = 0
        try:
            amt = (int) (input ("Enter the amount of that object that is currently present:"))
        except ValueError:
            print ("You have not entered a proper numerical value. Errno (STR_INT_SEGF).")
            breakpt = 0
        if amt < 0:
            print ("You cannot have less than 0 of the object. Errno (QUANT_ERR).")
            breakpt = 0
        it += 1
    file_val = open ("inventory.txt", "r")
    objects = file_val.readlines ()
    file_val.close ()
    complete = 0
    line_count = 0
    for line in objects:
        temp = object_in.lower ()
        temp2 = line.lower ()
        if temp.rstrip ("\n") in temp2.rstrip ("\n"):
            file_val2 = open ("inventory.txt", "w")
            concurrent_line = 0
            difference = 0
            for lines in objects:
                for d in range (len (object_in)):
                    if lines [d] != object_in [d]:
                        difference = 1
                        break
                if difference == 0:
                    objects [concurrent_line] = object_in + ":" + (str) (amt) + "\n"
                concurrent_line += 1
            file_val2.close ()
            file_return = open ("inventory.txt", "w")
            file_return.writelines (objects)
            complete = 1
        line_count += 1
    if complete == 0:
        file_val2 = open ("inventory.txt", "a")
        file_val2.write (object_in + ":" + (str) (amt) + "\n")
        file_val2.close ()
def delete_from_file ():
    student_file = open ("student.txt", "r")
    students = student_file.readlines ()
    it = 0
    breakpt = 1
    while True:
        if it != 0:
            if breakpt == 1:
                break
            else:
                breakpt = 0
        try:
            amt = (int) (input ("Enter the student number of the student you would like to delete:"))
        except ValueError:
            print ("That is not a numerical value. (STR_INT_SEGF).")
            breakpt = 0
        it += 1
    counter = 0
    for line in students:
        if (str) (amt) in line:
            students [counter] = ""
        counter += 1
    student_file.close ()
    student_file2 = open ("student.txt", "w")
    student_file2.writelines (students)
