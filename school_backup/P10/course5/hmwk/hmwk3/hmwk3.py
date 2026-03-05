import os
def q1 ():
    while True:
        filename = input ("Enter the name of the file that you wish to read data from (include file extensions):")
        if os.path.exists (filename):
            print ("File found. Algorithm Starting.")
            break
        else:
            print ("File not found in folder.")
    file = open (filename, 'r')
    string = file.read ()
    finished = []
    for character in string:
        if ord (character) in range (97, 122):
            finished += [character]
    filewrite = input ("Enter the name of the file that you wish to write the data to (include file extensions):")
    file_w2 = open (filewrite, 'a')
    file_w2.writelines (finished)
def q2 ():
    tier1ragebait = open ("professional.txt", "r")
    filecontent = tier1ragebait.read ()
    contents = [[0 for i in range (2)] for j in range (26)] 
    for letter in filecontent:
        if (ord (letter.lower ()) - 96) in range (1, 27):
            contents [ord (letter.lower ()) - 97][0] += 1
            contents [ord (letter.lower ()) - 97][1] = ord (letter.upper ())
    tier2ragebait = open ("poopy.txt", "w")
    #Sorting
    for xx in range (26):
        for yy in range (26):
            if contents [xx][0] < contents [yy][0]:
                temp1 = 0
                temp2 = 0
                temp1 = contents [xx][0]
                contents [xx][0] = contents [yy][0]
                contents [yy][0] = temp1
                temp2 = contents [xx][1]
                contents [xx][1] = contents [yy][1]
                contents [yy][1] = temp2
    for x in range (26):
        if contents [x][0] != 0 and contents [x][1] != 0:
            tier2ragebait.write (chr (contents [x][1]) + ":" + str (contents [x][0]) + "\n")       
    #TBL1
    tier2ragebait.close ()
    tier3ragebait = open ("poopy.txt", "r")
    contents2 = tier3ragebait.read ()
    print (contents2)
    print ("")
    #TBL2
    for y in range (26):
        if contents [y][0] != 0 and contents [y][1] != 0:
            print (chr (contents [y][1]) + ":", end = "")
            for z in range (contents [y][0]):
                print ("*", end = "")
            print ("")
q2 ()
