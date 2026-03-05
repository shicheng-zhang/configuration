import pickle
import datetime
def build_index ():
    index = {}
    try:
        file = open ("record.txt", "r")
        while True:
            offset = file.tell ()
            line = file.readline ()
            if not line:
                break
            if line.strip ():
                std_id = line.strip ().split ('|')[0]
                index [std_id] = offset
        file.close ()
    except FileNotFoundError:
        pass
    return index
def read_record (offset):
    file = open ("record.txt", "r")
    file.seek (offset)
    line = file.readline ()
    file.close ()
    return line
def first_name (std_id = None, line_num = None):
    index = build_index ()
    lines = []
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num is not None:
        if line_num < 1 or line_num > len (lines):
            print ("Invalid line number. Returning to home screen.")
            return
        line_c = lines [line_num - 1]
        std_id_str = line_c.strip ().split ('|')[0]
    else:
        std_id_str = str (std_id)
        if std_id_str not in index:
            print ("Student not present in catalogue. Returning to home screen.")
            return
        line_c = read_record (index [std_id_str])
    row_hand = line_c.strip ().split ('|')
    try:
        new_first_name = input ("Enter the new first name:")
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand [1] = new_first_name
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    file3 = open ("students.pkl", "wb")
    pickle.dump (lines, file3)
    file3.close ()
def last_name (std_id = None, line_num = None):
    index = build_index ()
    lines = []
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num is not None:
        if line_num < 1 or line_num > len (lines):
            print ("Invalid line number. Returning to home screen.")
            return
        line_c = lines [line_num - 1]
        std_id_str = line_c.strip ().split ('|')[0]
    else:
        std_id_str = str (std_id)
        if std_id_str not in index:
            print ("Student not present in catalogue. Returning to home screen.")
            return
        line_c = read_record (index [std_id_str])
    row_hand = line_c.strip ().split ('|')
    try:
        new_last_name = input ("Enter the new last name:")
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand [2] = new_last_name
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    file3 = open ("students.pkl", "wb")
    pickle.dump (lines, file3)
    file3.close ()
def mark (std_id = None, line_num = None):
    index = build_index ()
    lines = []
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num is not None:
        if line_num < 1 or line_num > len (lines):
            print ("Invalid line number. Returning to home screen.")
            return
        line_c = lines [line_num - 1]
        std_id_str = line_c.strip ().split ('|')[0]
    else:
        std_id_str = str (std_id)
        if std_id_str not in index:
            print ("Student not present in catalogue. Returning to home screen.")
            return
        line_c = read_record (index [std_id_str])
    row_hand = line_c.strip ().split ('|')
    try:
        new_mark = float (input ("Enter the new mark (Please enter a decimal mark with one decimal point):"))
    except ValueError:
        print ("STR_INT_FLT ERR.")
        return
    row_hand [3] = str (new_mark)
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    file3 = open ("students.pkl", "wb")
    pickle.dump (lines, file3)
    file3.close ()
def add_person (line_num = None):
    index = build_index ()
    while True:
        try:
            stdid = int (input ("Enter the new student's student ID:"))
        except ValueError:
            print ("STR_INT_FLT ERR.")
            continue
        if str (stdid) in index:
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
    newline = str (stdid) + "|" + first_name.strip () + "|" + last_name.strip () + "|" + str (mark).strip () + "\n"
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num is not None:
        if line_num < 1 or line_num > len (lines) + 1:
            print ("Invalid line number. Returning to home screen.")
            return
        lines.insert (line_num - 1, newline)
    else:
        lines.append (newline)
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    file3 = open ("students.pkl", "wb")
    pickle.dump (lines, file3)
    file3.close ()
def retrieve_record (line_num):
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num < 1 or line_num > len (lines):
        print ("Invalid line number. Returning to home screen.")
        return
    print ("Record at line", line_num, ":", lines [line_num - 1].rstrip ("\n"))
def delete_record (line_num):
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    if line_num < 1 or line_num > len (lines):
        print ("Invalid line number. Returning to home screen.")
        return
    del lines [line_num - 1]
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    file3 = open ("students.pkl", "wb")
    pickle.dump (lines, file3)
    file3.close ()
def disp_all ():
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
    line_num = -1
    print ("\n\n")
    print ("Enter 1: Change First Name of student")
    print ("Enter 2: Change Last Name of student")
    print ("Enter 3: Change Programming Mark of student")
    print ("Enter 4: Display all data")
    print ("Enter 5: Enter a new student")
    print ("Enter 6: Retrieve record by line number")
    print ("Enter 7: Delete record by line number")
    print ("Enter 8: Exit the program", end = "\n\n")
    disp_all ()
    print ("\n")
    while True:
        exit_c = 1
        try:
            choice = int (input ("Enter the action you want to undertake:"))
        except ValueError:
            print ("Not a numerical value.")
            exit_c = 0
        if choice not in [1, 2, 3, 4, 5, 6, 7, 8]:
            print ("You have not entered a valid choice.")
            exit_c = 0
        if exit_c == 1:
            break
    if choice in [1, 2, 3]:
        while True:
            try:
                method = int (input ("Mode: (1 to use Student ID, 2 to use line number):"))
                if method not in [1, 2]:
                    print ("Invalid method.")
                    continue
                break
            except ValueError:
                print ("Not a numerical value.")
        if method == 1:
            while True:
                break_c = 1
                try:
                    std_id = int (input ("Enter the student ID:"))
                except ValueError:
                    print ("Not a numerical value:")
                    break_c = 0
                if break_c == 1:
                    break
        else:
            while True:
                break_c = 1
                try:
                    line_num = int (input ("Enter the line number:"))
                except ValueError:
                    print ("Not a numerical value:")
                    break_c = 0
                if break_c == 1:
                    break
        if choice == 1:
            first_name (std_id if method == 1 else None, line_num if method == 2 else None)
        elif choice == 2:
            last_name (std_id if method == 1 else None, line_num if method == 2 else None)
        elif choice == 3:
            mark (std_id if method == 1 else None, line_num if method == 2 else None)
    elif choice == 4:
        disp_all ()
    elif choice == 5:
        while True:
            try:
                method = int (input ("Mode: (1 to input new line, 2 to insert at presented line number):"))
                if method not in [1, 2]:
                    print ("Invalid method.")
                    continue
                break
            except ValueError:
                print ("Not a numerical value.")
        if method == 2:
            while True:
                break_c = 1
                try:
                    line_num = int (input ("Enter the line number:"))
                except ValueError:
                    print ("Not a numerical value:")
                    break_c = 0
                if break_c == 1:
                    break
            add_person (line_num)
        else:
            add_person ()
    elif choice == 6:
        while True:
            break_c = 1
            try:
                line_num = int (input ("Enter the line number:"))
            except ValueError:
                print ("Not a numerical value:")
                break_c = 0
            if break_c == 1:
                break
        retrieve_record (line_num)
    elif choice == 7:
        while True:
            break_c = 1
            try:
                line_num = int (input ("Enter the line number:"))
            except ValueError:
                print ("Not a numerical value:")
                break_c = 0
            if break_c == 1:
                break
        delete_record (line_num)
    elif choice == 8:
        print ("Exiting.")
        exit (1)
