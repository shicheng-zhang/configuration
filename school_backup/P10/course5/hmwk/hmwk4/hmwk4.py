def first_name (std_id):
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close () 
    line_c = ""
    count_line = 0
    found = 0
    for line in lines:
        if line.strip ().split ()[0] == str (std_id):  
            line_c = line
            found = 1
            break
        count_line += 1
    if found == 0:
        print ("Student not present in catalogue. Returning to home screen.")
        return
    row_hand = line_c.strip ().split ()  
    try:
        new_first_name = input ("Enter the new first name:")  
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand [1] = new_first_name
    lines [count_line] = " " + row_hand [0].strip () + " " + row_hand [1].strip () + " " + row_hand [2].strip () + " " + row_hand [3].strip () + " \n"
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()  
def last_name (std_id):
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    line_c = ""
    count_line = 0
    found = 0
    for line in lines:
        if line.strip ().split ()[0] == str (std_id):
            line_c = line
            found = 1
            break
        count_line += 1
    if found == 0:
        print ("Student not present in catalogue. Returning to home screen.")
        return
    row_hand = line_c.strip ().split ()
    try:
        new_last_name = input ("Enter the new last name:")
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand [2] = new_last_name
    lines [count_line] = " " + row_hand [0].strip () + " " + row_hand [1].strip () + " " + row_hand [2].strip () + " " + row_hand [3].strip () + " \n"
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
def mark (std_id):
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    line_c = ""
    count_line = 0
    found = 0
    for line in lines:
        if line.strip ().split ()[0] == str (std_id):
            line_c = line
            found = 1
            break
        count_line += 1
    if found == 0:
        print ("Student not present in catalogue. Returning to home screen.")
        return
    row_hand = line_c.strip ().split ()
    try:
        new_mark = float (input ("Enter the new mark (Please enter a decimal mark with one decimal point):"))
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand[3] = str (new_mark)
    lines [count_line] = " " + row_hand [0].strip () + " " + row_hand [1].strip () + " " + row_hand [2].strip () + " " + row_hand [3].strip () + " \n"
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
def add_person ():
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    total_lines = [line.strip ().split ()[0] for line in lines] 
    while True:
        try:
            stdid = int (input ("Enter the new student's student ID:"))
        except ValueError:
            print ("STR_INT_FLT ERR.")
            continue
        if str (stdid) in total_lines:
            print ("Student ID already present in catalogue. Returning to Home Screen.")
            continue
        else:
            break
    try:
        first_name = input ("Enter the new student's first name:")
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    try:
        last_name = input ("Enter the new student's last name:")
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    try:
        mark = float (input ("Enter the new student's mark:"))
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    newline = str (stdid) + " " + first_name.strip () + " " + last_name.strip () + " " + str (mark).strip () + " \n"
    lines += [newline]
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
def disp_all():
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    print ("All Data is displayed in the format of: Student ID, First Name, Last Name, Programming Mark.")
    for line in lines:
        print (line.rstrip ("\n"))
print ("Welcome to the Catalogue.")
print ("Available options are:")
while True:
    choice = 0
    std_id = -1
    print ("\n\n")
    print ("Enter 1: Change First Name of student")
    print ("Enter 2: Change Last Name of student")
    print ("Enter 3: Change Programming Mark of student")
    print ("Enter 4: Display all data")
    print ("Enter 5: Enter a new student")
    print ("Enter 6: Exit the program", end="\n\n")
    disp_all ()
    print ("\n")
    while True:
        exit_c = 1
        try:
            choice = int (input ("Enter the action you want to undertake:"))
        except ValueError:
            print ("Not a numerical value.")
            exit_c = 0
        if choice not in range (1, 7):
            print ("You have not entered a valid choice.")
            exit_c = 0
        if exit_c == 1:
            break
    if choice == 1:
        while True:
            break_c = 1
            try:
                std_id = int (input ("Enter the student ID:"))
            except ValueError:
                print ("Not a numerical value:")
                break_c = 0
            if break_c == 1:
                break
        first_name (std_id)
    elif choice == 2:
        while True:
            break_c = 1
            try:
                std_id = int (input ("Enter the student ID:"))
            except ValueError:
                print ("Not a numerical value:")
                break_c = 0
            if break_c == 1:
                break
        last_name (std_id)
    elif choice == 3:
        while True:
            break_c = 1
            try:
                std_id = int (input ("Enter the student ID:"))
            except ValueError:
                print ("Not a numerical value:")
                break_c = 0
            if break_c == 1:
                break
        mark (std_id)
    elif choice == 4:
        disp_all ()
    elif choice == 5:
        add_person ()
    elif choice == 6:
        print ("Exiting.")
        exit (1)
