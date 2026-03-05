import copy
import time
def executioner (neighbours, life):
    if life == 1:
        #currently alive
        if neighbours < 2 or neighbours > 3:
            life = 0
            #dead is neighbours are irregular
            return life
        else:
            return life
    else:
        #currently dead
        if neighbours == 3:
            #resurrected is 3 neighbours
            life = 1
            return life
        else:
            return life
    return life
def reaffixtion (main_grid, sub_grid):
    length_x = len (main_grid [0])
    length_y = len (main_grid)
    for y in range (length_y):
        for x in range (length_x):
            #Reaffix sub_grid values back to main grid
            main_grid [y][x] = sub_grid [y][x]
    return main_grid
def find_neighbours (main_grid, sub_grid):
    list_neighbour_possible = [-1, 0, 1] #Possible Vectoring
    actual_neighbours = 0
    length_x = len (main_grid [0])
    length_y = len (main_grid)
    for y2 in range (length_y):
        for x2 in range (length_x):
            #Test for each value within the grid
            for z in range (3):
                for a in range (3):
                    if a == 1 and z == 1: #Circulate all possible vectors except (x + 0, y + 0)
                        continue
                    else:
                        current_x = x2 + list_neighbour_possible [z]
                        current_y = y2 + list_neighbour_possible [a]
                        if current_x > -1 and current_x < length_x:
                            if current_y > -1 and current_y < length_y:
                                #Check if in bounds complete
                                actual_neighbours += main_grid [current_y][current_x]
            sub_grid [y2][x2] = executioner (actual_neighbours, main_grid [y2][x2])
            actual_neighbours = 0 #Reset neighbour count for next grid value
    return sub_grid
def print_grid (grid):
    print ("")
    length_y = len (grid)
    length_x = len (grid [0])
    live_cells = 0
    dead_cells = 0
    total_cells = length_x * length_y
    print ("    ", end = "") 
    for x3 in range (length_x):
        print (x3 % 10, "  ", end = "") 
    print ("x")
    for y in range (length_y):
        print ("  ", end = "") 
        for x2 in range (length_x):
            print ("  - ", end = "") #Line Barriers
        print ("")
        print (y % 10, "|", end = "") #Vert Barriers
        for x in range (length_x):
            if grid [y][x] == 1:
                #grid [y][x] is alive
                print (" # |", end = "")
                live_cells += 1
            else:
                #grid [y][x] is dead
                print ("   |" , end = "") 
        print ("")
    print ("  ", end = "") 
    for x3 in range (length_x):
        print ("  - ", end = "")
    print ("")
    print ("y")
    dead_cells = total_cells - live_cells
    print ("Cells Alive: ", live_cells)
    print ("Cells Dead: ", dead_cells)
    print ("Percentage Alive: ", live_cells / total_cells * 100, "%")
grid_size_x = 0
grid_size_y = 0
try:
    grid_size_x = (int) (input ("Enter the horizontal size of the grid:"))
except ValueError:
    print ("Not a number value entered.")
    exit (1)
if grid_size_x < 2 or grid_size_x > 99:
    print ("The grid has to have dimensions larger than 1 and smaller than 100.")
    exit (1)
try:
    grid_size_y = (int) (input ("Enter the vertical size of the grid:"))
except ValueError:
    print ("Not a number value entered:")
    exit (1)
if grid_size_y < 2 or grid_size_y > 99:
    print ("The grid has to have dimensions larger than 1 and smaller than 100.")
    exit (1)
game_grid = [[0 for x3 in range (grid_size_x)] for y3 in range (grid_size_y)]
copy_grid = [[0 for x4 in range (grid_size_x)] for y4 in range (grid_size_y)]
print_grid (game_grid)
num_seed = 0
try:
    num_seed = (int) (input ("Enter how many seeds that you want to define the starting grid with:"))
except ValueError:
    print ("Not a number value.")
    exit (1)
if num_seed < 1:
    print ("You have to have at least 1 seed:")
    exit (1)
seeds = [[0 for x5 in range (num_seed)] for y5 in range (2)]
for b in range (num_seed):
    try:
        seeds [0][b] = (int) (input ("Enter the x coordinate for this seed:"))
    except ValueError:
        print ("Not a number input.")
        exit (1)
    if seeds [0][b] < 0 or seeds [0][b] >= grid_size_x:
        print ("Coordinates cannot have a index of less than 0 or more than the max.")
        exit (1)
    try:
        seeds [1][b] = (int) (input ("Enter the y coordinate for this seed:"))
    except ValueError:
        print ("Not a number input.")
        exit (1)
    if seeds [1][b] < 0 or seeds [1][b] >= grid_size_y:
        print ("Coordinates cannot have a index of less than 0 or more than the max.")
        exit (1)
    #Affix seed coordinates to main grid for seeding
    game_grid [seeds [1][b]][seeds [0][b]] = 1
    copy_grid [seeds [1][b]][seeds [0][b]] = 1
    print_grid (game_grid)
game_mode = -1
#Enter the game modes
try:
    game_mode = (int) (input ("Enter the game_mode that you like (0 for manual, 1 for automatic):"))
except ValueError:
    print ("Impossible game mode.")
    exit (1)
if game_mode != 0 and game_mode != 1:
    print ("Impossible game mode.")
    exit (1)
iteration_count = 0
try:
    iteration_count = (int) (input ("Enter the number of generations that you would like this to run:"))
except ValueError:
    print ("Not a number input.")
    exit (1)
if iteration_count < 1:
    print ("You cannot have the game run for less than 1 generation.")
    exit (1)
iteration_count += 0
if game_mode == 0:
    for counter in range (iteration_count):
        #Manual Mode, user input continues generation
        decision = 'y'
        try:
            decision = (str) (input ("Do you want to continue the generation (y/n):"))
        except ValueError:
            print ("Not a char input.")
            exit (1)
        if decision == 'n':
            print ("Thank you for playing.")
            exit (1)
        elif decision == 'y':
            copy_grid = find_neighbours (game_grid, copy_grid)
            game_grid = reaffixtion (game_grid, copy_grid)
            copy_grid = copy.deepcopy (game_grid)
            print_grid (game_grid)
elif game_mode == 1:
    #Automatic mode, contiguously generate
    millisecond_delay = 0
    try:
        millisecond_delay = (int) (input ("Enter the number of milliseconds present in the printout delay:"))
    except ValueError:
        print ("Not a number value.")
        exit (1)
    if millisecond_delay < 25:
        print ("Less than 25 ms of delay is not recommended.")
        exit (1)
    for counter2 in range (iteration_count):
        copy_grid = find_neighbours (game_grid, copy_grid)
        game_grid = reaffixtion (game_grid, copy_grid)
        copy_grid = copy.deepcopy (game_grid)
        print_grid (game_grid)
        print ("Generation: ", counter2)
        time.sleep (millisecond_delay / 1000)

