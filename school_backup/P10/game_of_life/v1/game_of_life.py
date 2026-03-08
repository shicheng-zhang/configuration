import os
import time
import copy
#Possible values for the grid
# -2 is Err (NULL), -1 is uninistalised/Just initialsied, 0 is dead, 1 is alive, 2 is marked for death, 3 is marked for resurrection
def executioner (neighbours, life):
    life2 = life
    if life2 == 1:
        if neighbours < 2 or neighbours > 3:
            #Cell Dies
            life2 = 0 #Dead/False state
            return life2
        elif neighbours == 2 or neighbours == 3:
            #Cell stays alive
            return life2 #Live/True state
    elif life2 == 0 or life2 == -1:
        if neighbours == 3:
            life2 = 1 #Resurrection
            return life2 
        else:
            #Nothing happens
            return life2
    else:
        life2 = -2 #Error Code
        return life2
    return life2
def reaffixtion (main_grid, new_grid):
    length_x = len (main_grid [0])
    length_y = len (main_grid)
    for y5 in range (length_y):
        for x5 in range (length_x):
            if new_grid [y5][x5] == 1:
                main_grid [y5][x5] = 1 
            else:
                main_grid [y5][x5] = 0
            # Update main grid with new grid
    return main_grid
def find_neighbours (grid, new_grid):
    length_x = len (grid [0])
    length_y = len (grid)
    for y3 in range (length_y):
        for x3 in range (length_x):
            list_neighbours = 0  # Initialize inside the loops for each cell
            if x3 == 0:
                # Left Wall
                if y3 == 0:
                    # Left and Upper Wall
                    list_neighbours = grid [0][1] + grid [1][0] + grid [1][1]
                    new_grid [0][0] = executioner (list_neighbours, grid [0][0])
                elif y3 == length_y - 1:
                    # Left and lower Wall
                    list_neighbours = grid [y3 - 1][0] + grid [y3 - 1][1] + grid [y3][1]
                    new_grid [y3][0] = executioner (list_neighbours, grid [y3][0])
                else:
                    # Left Wall Only
                    list_neighbours = grid [y3 - 1][x3] + grid [y3 - 1][x3 + 1] + grid [y3][x3 + 1] + grid [y3 + 1][x3 + 1] + grid [y3 + 1][x3]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
            elif x3 == length_x - 1:
                # Right Wall
                if y3 == 0:
                    # Right and Upper Wall
                    list_neighbours = grid [0][x3 - 1] + grid [1][x3 - 1] + grid [1][x3]
                    new_grid [0][x3] = executioner (list_neighbours, grid [0][x3])
                elif y3 == length_y - 1:
                    # Right and lower Wall
                    list_neighbours = grid [y3 - 1][x3] + grid [y3 - 1][x3 - 1] + grid [y3][x3 - 1]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
                else:
                    # Right Wall only
                    list_neighbours = grid [y3 - 1][x3] + grid [y3 - 1][x3 - 1] + grid [y3][x3 - 1] + grid [y3 + 1][x3 - 1] + grid [y3 + 1][x3]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
            else:
                if y3 == 0:
                    # Upper Wall only
                    list_neighbours = grid [y3][x3 - 1] + grid [y3 + 1][x3 - 1] + grid [y3 + 1][x3] + grid [y3 + 1][x3 + 1] + grid [y3][x3 + 1]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
                elif y3 == length_y - 1:
                    # lower Wall only
                    list_neighbours = grid [y3][x3 - 1] + grid [y3 - 1][x3 - 1] + grid [y3 - 1][x3] + grid [y3 - 1][x3 + 1] + grid [y3][x3 + 1]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
                else:
                    # No Wall
                    list_neighbours = grid [y3 - 1][x3 - 1] + grid [y3 - 1][x3] + grid [y3 - 1][x3 + 1] + grid [y3][x3 - 1] + grid [y3][x3 + 1] + grid [y3 + 1][x3 - 1] + grid [y3 + 1][x3] + grid [y3 + 1][x3 + 1]
                    new_grid [y3][x3] = executioner (list_neighbours, grid [y3][x3])
    return new_grid
def print_grid (grid):
    os.system ("clear")
    length_y = len (grid)
    length_x = len (grid [0])
    print ("    ", end = "")
    for x3 in range (length_x):
        print (x3 % 10, "  ", end = "")
    print ("x")
    for y in range (length_y):
        print ("  ", end = "")
        for x2 in range (length_x):
            print ("  - ", end = "")
        print ("")
        print (y % 10, "|", end = "")
        for x in range (length_x):
            if grid [y][x] == 1:
                #If grid [y][x] is alive
                print (" # |", end = "")
            else:
                #grid [y][x] is dead
                print ("   |" , end = "")
            #print (" ", grid [y][x], " |", end = "")
        print ("")
    print ("  ", end = "")
    for x3 in range (length_x):
        print ("  - ", end = "")
    print ("")
    print ("y")
grid_size_x = -1
grid_size_y = -1
try:
    grid_size_x = (int) (input ("Enter the x size of the game grid:"))
except ValueError:
    exit (1) 
if grid_size_x < 2:
    print ("You cannot have a dimension of size 1.")
    exit (1)
try:
    grid_size_y = (int) (input ("Enter the y size of the game grid:"))
except ValueError:
    exit (1)
if grid_size_y < 2:
    print ("You cannot have a dimension of size 1.")
    exit (1)
game_grid = [[0 for x in range (grid_size_x)] for y in range (grid_size_y)]
secondary_grid = [[0 for x2 in range (grid_size_x)] for y2 in range (grid_size_y)]
print_grid (game_grid)
num_seed = -1 #Initialise
try:
    num_seed = (int) (input ("Enter the amount of seeds you would like to enter:"))
except ValueError:
    print ("Not a number input.")
    exit (1)
if num_seed < 1:
    print ("You cannot have less than 1 seed value.")
    exit (1)
list_seeds = [[-1 for a in range (2)] for z in range (num_seed)] #Initialise
for b in range (num_seed):
    try:
        list_seeds [b][0] = (int) (input ("Enter the x coordinate of the seed:"))
        list_seeds [b][1] = (int) (input ("Enter the y coordinate of the seed:"))
    except ValueError:
        print ("Not a number input.")
        exit (1)
    if list_seeds [b][0] < 0 or list_seeds [b][0] > grid_size_x - 1:
        print ("Impossible index. (-1 < n < grid_size_x), grid_size_x = ", grid_size_x, ", Your value = ", list_seeds [b][0])
        exit (1)
    else:
        if list_seeds [b][1] < 0 or list_seeds [b][1] > grid_size_y - 1:
            print ("Impossible index. (-1 < n < grid_size_y), grid_size_y = ", grid_size_y, ", Your value = ", list_seeds [b][1])
    game_grid [list_seeds [b][1]][list_seeds [b][0]] = 1 #Alive
    secondary_grid [list_seeds [b][1]][list_seeds [b][0]] = 1 #Alive
    print_grid (game_grid)
iteration = -1 #Initialise
space_time_iteration = 1000 #Default to 1 second, 1000 miliseconds
try:
    iteration = (int) (input ("Enter the number of iteration that you wish this game to run:"))
except ValueError:
    print ("Not a number value.")
    exit (1)
if iteration < 1:
    print ("You cannot run for less than 1 iteration:")
    exit (1)
game_mode = -1 #Uninitialised
try:
    game_mode = (int) (input ("Enter the mode of the virtual machine (0 for manual continuation, 1 for automatic generation):"))
except ValueError:
    print ("Not a number value.")
    exit (1)
if game_mode == 0:
    #Manual Game
    for d in range (iteration):
        continuation = 'y' #Initialise at yes
        print_grid (game_grid)
        try:
            continuation = (str) (input ("Do you want to continue to the next generation (y/n)?"))
        except ValueError:
            print ("You had to enter y or n.")
            exit (1)
        if continuation == 'n':
            #Exit Game
            print ("Thank You for Playing.")
            exit (1)
        temp_grid = copy.deepcopy (game_grid)
        secondary_grid = find_neighbours (temp_grid, secondary_grid)
        game_grid = reaffixtion (game_grid, secondary_grid)
        secondary_grid = copy.deepcopy (game_grid)
elif game_mode == 1:
    #Automatic generation
    space_time_iteration = 1000 #Default to 1 second, 1000 miliseconds
    try:
        space_time_iteration = (int) (input ("Enter the number of miliseconds of delay is present between each iteration (1 s = 1000 ms):"))
    except ValueError:
        print ("Not a number value.")
        exit (1)
    if space_time_iteration < 100:
        print("Running with less than 100 miliseconds under the clock is not recommended.")
        exit (1)
    for e in range (iteration):
        print_grid (game_grid)
        temp_grid = copy.deepcopy (game_grid)
        secondary_grid = find_neighbours (temp_grid, secondary_grid)
        game_grid = reaffixtion (game_grid, secondary_grid)
        secondary_grid = copy.deepcopy (game_grid)
        time.sleep ((float) (space_time_iteration / 1000))
else:
    print ("Invalid game mode.")
    exit (1)
