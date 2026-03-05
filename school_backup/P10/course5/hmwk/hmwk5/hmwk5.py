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
def first_name (std_id):
    index = build_index ()
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
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    try:
        file3 = open ("changes.bin", "rb")
        logs = pickle.load (file3)
        file3.close ()
    except (FileNotFoundError, EOFError):
        logs = []
    try:
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|1"]
    except TypeError:
        logs = []
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|1"]
    file4 = open ("changes.bin", "wb")
    pickle.dump (logs, file4)
    file4.close ()
def last_name (std_id):
    index = build_index ()
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
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    try:
        file3 = open ("changes.bin", "rb")
        logs = pickle.load (file3)
        file3.close ()
    except (FileNotFoundError, EOFError):
        logs = []
    try:
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|2"]
    except TypeError:
        logs = []
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|2"]
    file4 = open ("changes.bin", "wb")
    pickle.dump (logs, file4)
    file4.close ()
def mark (std_id):
    index = build_index ()
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
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    count_line = 0
    for line in lines:
        if line.strip ().split ('|')[0] == std_id_str:
            lines [count_line] = row_hand [0].strip () + "|" + row_hand [1].strip () + "|" + row_hand [2].strip () + "|" + row_hand [3].strip () + "\n"
            break
        count_line += 1
    file2 = open ("record.txt", "w")
    file2.writelines (lines)
    file2.close ()
    try:
        file3 = open ("changes.bin", "rb")
        logs = pickle.load (file3)
        file3.close ()
    except (FileNotFoundError, EOFError):
        logs = []
    try:
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|3"]
    except TypeError:
        logs = []
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + std_id_str + "|3"]
    file4 = open ("changes.bin", "wb")
    pickle.dump (logs, file4)
    file4.close ()
def add_person ():
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
    file2 = open ("record.txt", "a")
    file2.write (newline)
    file2.close ()
    try:
        file3 = open ("changes.bin", "rb")
        logs = pickle.load (file3)
        file3.close ()
    except (FileNotFoundError, EOFError):
        logs = []
    try:
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + str (stdid) + "|5"]
    except TypeError:
        logs = []
        timestamp = datetime.datetime.now ().strftime ("%Y-%m-%d %H:%M:%S")
        logs = logs + [timestamp + "|" + str (stdid) + "|5"]
    file4 = open ("changes.bin", "wb")
    pickle.dump (logs, file4)
    file4.close ()
def disp_all ():
    file = open ("record.txt", "r")
    lines = file.readlines ()
    file.close ()
    print ("All Data is displayed in the format of: Student ID, First Name, Last Name, Programming Mark.")
    for line in lines:
        print (line.rstrip ("\n"))
def access_logs ():
    try:
        file = open ("changes.bin", "rb")
        logs = pickle.load (file)
        file.close ()
    except (FileNotFoundError, EOFError):
        logs = []
    print ("All Logged Changes are displayed in the format of: Date Time, Student ID, Change Type.")
    for log in logs:
        print (log.rstrip ("\n"))
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
    print ("Enter 7: Display all logged changes")
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
        if choice not in [1, 2, 3, 4, 5, 7, 8]:
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
    elif choice == 7:
        access_logs ()
    elif choice == 8:
        print ("Exiting.")
        exit (1)
