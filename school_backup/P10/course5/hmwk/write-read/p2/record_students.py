#Data will be stored in catalogue.txt
#Options for catalogue are 1 = display all records, 2 = search for a student by name, 3 = Update marks, 4 = Remove a student from catalogue, 5 = add student to catalogue, 6 is to quit
def disp_all_records ():
    student_data_all = open ("catalogue.txt", "r")
    output_data_flow = student_data_all.read ()
    print (output_data_flow)
    student_data_all.close ()
def search_for_student (name):
    all_data = open ("catalogue.txt", "r")
    complete = 0
    for lines in all_data:
        if name.lower () in lines.lower ():
            print (lines)
            complete = 1
    if complete == 0:
        print ("Student not found.")
    all_data.close ()
def update_marks (name, mark):
    all_data = open ("catalogue.txt", "r")
    lines = all_data.readlines ()
    all_data.close ()
    all_data2 = open ("catalogue.txt", "w")
    complete = 0
    for line in lines:
        if name.lower () in line.lower ():
            all_data2.write (name + ": " + str (mark) + "\n")
            complete = 1
        else:
            all_data2.write (line)
    all_data2.close ()
    if complete == 0:
        print ("Student not within catalogue.")
    else:
        disp_all_records ()
def remove_student (name):
    data_stream = open ("catalogue.txt", "r")
    lines = data_stream.readlines ()
    data_stream.close ()
    data_stream2 = open ("catalogue.txt", "w")
    complete = 0
    for line in lines:
        if name.lower () in line.lower ():
            data_stream2.write ("")
            complete = 1
        else:
            data_stream2.write (line)
    data_stream2.close ()
    if complete == 0:
        print ("Student not within catalogue.")
    else:
        disp_all_records ()
def add_student (name, mark):
    d_stream = open ("catalogue.txt", "r")
    lines = d_stream.readlines ()
    d_stream.close ()
    d_stream2 = open ("catalogue.txt", "a")
    ispresent = 0 
    for line in lines:
        if name.lower () in line.lower ():
            ispresent = 1
    if ispresent == 1:
        print ("Student already present within the catalogue.")
    else:
        d_stream2.write (name + ": " + str (mark) + "\n")
        disp_all_records ()
choice = 0
while True:
    choice = (int) (input ("Are you displaying all records, seaching for a student, updating marks, removing a student, or adding a student (1, 2, 3, 4, 5 respective. 6 to quit)?"))
    if choice not in range (1, 7):
        print ("Not a valid choice.")
    else:
        if choice == 1:
            disp_all_records ()
        elif choice == 2:
            name = input ("Enter the name of the student you wish to find:")
            search_for_student (name)
        elif choice == 3:
            name = input ("Enter the name of the student whom you wish to update marks for:")
            new_mark = (int) (input ("Enter the new mark that they are recieving:"))
            update_marks (name, new_mark)
        elif choice == 4:
            name = input ("Enter the name of the student that you would like to remove:")
            remove_student (name)
        elif choice == 5:
            name = input ("Enter the name of the student that you would like to enter:")
            mark = (int) (input ("Enter the mark of the student:"))
            add_student (name, mark)
        else:
            print ("Exiting.")
            break


