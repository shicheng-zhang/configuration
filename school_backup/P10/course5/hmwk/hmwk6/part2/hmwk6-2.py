import pickle
student_log = {}
def pickle_to ():
    file = open ("students.pkl", "wb")
    pickle.dump (student_log, file)
    file.close ()
def pickle_from ():
    file = open ("students.pkl", "rb")
    student_log = pickle.load (file)
    file.close ()
print ("WARNING: ALL CHANGES ARE AUTOMATICALLY WRITTEN TO STUDENTS.PKL")
while True:
    while True:
        exit_c = 1
        try:
            option = int (input ("What action would you like to undertake (0 for adding person/updating information, 1 for deleting person, 2 for printing current catalogue, 3 to quit):"))
        except ValueError:
            print ("STR_INT_FLT_ERR.")
            exit_c = 0
        if option not in range (0, 5):
            print ("Option not available.")
            exit_c = 0
        if exit_c == 1:
            break 
    if option == 0:
        std_id = 0
        name = ""
        mark = 0.0
        while True:
            exit_c = 1
            try:
                std_id = int (input ("Student ID:"))
            except ValueError:
                print ("STR_INT_FLT_ERR.")
                exit_c = 0
            if exit_c == 1:
                break
        while True:
            exit_c = 1
            try:
                name = input ("Name:")
            except ValueError:
                print ("STR_INT_FLT_ERR.")
                exit_c = 0
            if exit_c == 1:
                break
        while True:
            exit_c = 1
            try:
                mark = float (input ("Mark:"))
            except ValueError:
                print ("STR_INT_FLT_ERR.")
                exit_c = 0
            if mark > 100 or mark < 0:
                print ("Invalid Mark.")
                exit_c = 0
            if exit_c == 1:
                break
        student_log [(str) (std_id)] = {"name": name, "mark": mark}
    elif option == 1:
        while True:
            exit_c = 1
            try:
                std_id = int (input ("Student ID to remove:"))
            except ValueError:
                print ("STR_INT_FLT_ERR.")
                exit_c = 0
            if exit_c == 1:
                break
        if std_id in student_log:
            student_log.pop (std_id)
        else:
            print ("No such student ID in catalogue:")
    elif option == 2:
        pickle_from ()
        print (student_log)
    elif option == 3:
        print ("Exiting.")
        exit (1)
    pickle_to ()
