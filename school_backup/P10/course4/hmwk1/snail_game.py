import os
def print_grid (grid):
    os.system ('clear')
    len_x = len (grid)
    print (" ", end = "")
    for z in range (len_x):
        print ("-", end = " ")
    print ("")
    for x in range (len (grid)):
        print ("|", end = "")
        for y in range (len (grid [x])):
            if (grid [y][x] == -1):
                print (" ", end = " ")
            elif (grid [y][x] == 0):
                print ("-", end = " ")
            elif (grid [y][x] == 1):
                print ("@", end = " ")
            else:
                #Error
                exit (1)
        print ("|")
    print (" ", end = "")
    for a in range (len_x):
        print ("-", end = " ")
    print ("")
len_x = (int) (input ("Enter the x length of the grid:"))
len_y = (int) (input ("Enter the y length of the grid:"))
grid = [[-1 for x in range (len_y)] for y in range (len_x)]
start_x = (int) (input ("Enter the starting x coordinate of the snail:"))
start_y = (int) (input ("Enter the starting y coordinate of the snail:"))
prev_x = -1
prev_y = -1
current_x = start_x
current_y = start_y
new_x = -1
new_y = -1
move = 'q'
while True:
    try: 
        move = (str) (input ("Enter the movement that you want:"))
    except ValueError:
        print ("Wrong Input.")
        continue
    if move == 'a':
        new_y = current_y - 1
        new_x = current_x
    elif move == 'w':
        new_x = current_x - 1
        new_y = current_y
    elif move == 'd':
        new_y = current_y + 1
        new_x = current_x
    elif move == 's':
        new_x = current_x + 1
        new_y = current_y
    elif move == 'q':
        exit (1)
    else:
        print ("-500 Social Credit")
        continue
    #Placeholder
    if ((new_y > -1) and (new_y < len_y)) and ((new_x > -1) and (new_x < len_x)):
        grid [new_y][new_x] = 1
        grid [current_y][current_x] = 0
    else:
        print ("You have crashed.")
        exit (1)
    current_x = new_x
    current_y = new_y
    prev_x = current_x
    prev_y = current_y
    new_x = 0
    new_y = 0
    print_grid (grid)

