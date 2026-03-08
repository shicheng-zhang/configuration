import select
import sys
import termios
import tty
import os
#This is for saving the last state of the game
SAVE_PATH = "/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/main_data/last_state_gme.txt"
#Start and stop raw mode is to allow for instant keypress input when playing the game to allow for smoother game play
def start_raw_mode ():
    fd = sys.stdin.fileno ()
    old_settings = termios.tcgetattr (fd)
    new_settings = termios.tcgetattr (fd)
    new_settings [3] &= ~(termios.ECHO | termios.ICANON)
    termios.tcsetattr (fd, termios.TCSADRAIN, new_settings)
    return old_settings
def end_raw_mode (old_settings):
    fd = sys.stdin.fileno ()
    termios.tcsetattr (fd, termios.TCSADRAIN, old_settings)
#This is for loading the last position and room the player was in. Imported from SAVE_PATH and return the room number and x and y coordinates
def load_last_position ():
    try:
        with open (SAVE_PATH, "r") as f:
            lines = f.read ().splitlines ()
            #Room No, X, Y coordinates
            return int (lines [0]), int(lines [1]), int(lines [2])
    except:
        return None
#This is for saving the last position of the player in the game as well as the room they were in. Inverse of load_last_position
def save_last_position (room, x, y):
    with open (SAVE_PATH, "w") as f:
        f.write (f"{room}\n{x}\n{y}\n")
#After one has completed the game, this function clears the saved position file for the next time the game is played
def clear_saved_position ():
    with open (SAVE_PATH, "w") as f:
        f.write ("")
#This function manually loads the individual room data from the room files in the pre_load_seed file folder, containing the "rooms" for the game.
def get_room_data ():
    try:
        #Room openings
        rm1 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room1.txt", "r")
        rm2 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room2.txt", "r")
        rm3 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room3.txt", "r")
        rm4 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room4.txt", "r")
        rm5 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room5.txt", "r")
        rm6 = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/room6.txt", "r")
        last_rm = open ("/home/magi-01/CODE/SCHOOL/Programming_Course/P10/project/pre_load_seed/last_rm.txt", "r")
        #Load each room as a string list for character processing
        room1 = [line.rstrip('\n') for line in rm1.readlines ()]
        room2 = [line.rstrip('\n') for line in rm2.readlines ()]
        room3 = [line.rstrip('\n') for line in rm3.readlines ()]
        room4 = [line.rstrip('\n') for line in rm4.readlines ()]
        room5 = [line.rstrip('\n') for line in rm5.readlines ()]
        room6 = [line.rstrip('\n') for line in rm6.readlines ()]
        last_room = [line.rstrip('\n') for line in last_rm.readlines ()]
        #Close each file to prevent buffer overflow
        rm1.close ()
        rm2.close ()
        rm3.close ()
        rm4.close ()
        rm5.close ()
        rm6.close ()
        last_rm.close ()
        #Combine all rooms as a 2D matrix list and return it as the combined rooms loading function for the game
        rooms = [room1, room2, room3, room4, room5, room6, last_room]
        return rooms
    #Redundancy if files and filenames are corrupted
    except FileNotFoundError:
        sys.exit (1)
#This function switches the room based on the current room index, door placing, direction of player, and if the player has the key or no.
def switch_room (rooms, current_room_index, door_x, door_y, direction, set_mode, has_key):
    #Special case for room 6, which only allows one door to be taken 
    if current_room_index == 5:
        if (door_x, door_y) == (19, 5):
            #If the player takes the right door, load the trophy room
            new_room_index = 6
            #Starting spot for the player in the trophy room
            new_player_x, new_player_y = 1, 5
            new_room_data = rooms [new_room_index]
            line = list (new_room_data [new_player_y])
            #Spawns the player in the trophy room
            line [new_player_x] = "!"
            new_room_data [new_player_y] = "".join (line)
            rooms [new_room_index] = new_room_data 
            return new_room_index, new_room_data, new_player_x, new_player_y, False
        else:
            #This is for if the player takes the wrong door. The game ends here.
            print ("You took the wrong door. Game Over.")
            end_raw_mode (set_mode)
            sys.exit ()
    if current_room_index != 5 and not has_key:
        #This does not allow the player to continue to the next room if they do not possess the key in rooms 1-5
        print ("You need a key to proceed!")
        return current_room_index, rooms [current_room_index], door_x, door_y, has_key
    new_room_index = current_room_index
    #This following part is for door travel, the first condition is for the next room, and the second is for returning to the previous room.
    if direction == "next" and current_room_index < 6:
        new_room_index += 1
        new_player_x, new_player_y = 1, 5
    elif direction == "prev" and current_room_index > 0:
        new_room_index -= 1
        new_player_x, new_player_y = 5, 5
    else:
        return current_room_index, rooms [current_room_index], door_x, door_y, has_key
    #This is for the final scenario when the player is in the final room and about to exit the interface.
    new_room_data = rooms [new_room_index]
    line = list (new_room_data [new_player_y])
    #Spawns the player in the trophy room.
    line [new_player_x] = "!"
    new_room_data [new_player_y] = "".join (line)
    rooms [new_room_index] = new_room_data
    return new_room_index, new_room_data, new_player_x, new_player_y, False
def main ():
    #Introduction message and teaching the player how to play.
    print ("Welcome to Counter Strike: Trophy Offensive.")
    print ("The game is extremely simple, in each room apart from the sixth you will find a key.")
    print ("Each key opens the door to the next room.")
    print ("The sixth room is a test of your wits.")
    print ("For all other rooms, you require the key to open the door.")
    print ("You will recieve hints about where the key is in each of the rooms.")
    print ("WASD is used to navigate, I is for interactions with objects, and Q is to quit and save.")
    print ("Interact with objects to get the key.")
    print ("Press Enter to start the game.")
    input ()
    os.system ("clear")
    #Loads the room and makes the terminal go into raw mode for game mode.
    rooms = get_room_data ()
    restored = load_last_position ()
    set_mode = start_raw_mode ()
    #Checks for restored progress, if the player agrees to load the old game, the old game files are loaded.
    if restored:
        os.system ("clear")
        choice = input("Restore previous game? (Y/N): ").strip ().lower ()
        #Load old game files
        if choice == "y":
            current_room, now_x, now_y = restored
        #Restarting from the beginning
        else:
            current_room, now_x, now_y = 0, 1, 5
    else:
        current_room, now_x, now_y = 0, 1, 5
    #get the room data
    room_data = rooms [current_room]
    #Mark the presence of the key on or off the player
    has_key = False
    #Prepares the room for player interactions
    temp = list (room_data [now_y])
    temp [now_x] = "!"
    room_data [now_y] = "".join (temp)
    rooms [current_room] = room_data
    os.system ("clear")
    for line in room_data: print (line)
    print ("\nWASD for movement, I to interact, Q to quit.")
    while True:
        #Mark the present coordinates of the player as now_y and now_x for marking possible movements
        possible_target_coords = []
        if now_y > 0: possible_target_coords.append ((now_x, now_y - 1))
        if now_y < len (room_data) - 1: possible_target_coords.append ((now_x, now_y + 1))
        if now_x > 0: possible_target_coords.append ((now_x - 1, now_y))
        if now_x < len (room_data [now_y]) - 1: possible_target_coords.append ((now_x + 1, now_y))
        #Allows for instant keypress command input
        ready, _, _ = select.select ([sys.stdin], [], [], 0.1)
        command = sys.stdin.read (1) if sys.stdin in ready else None
        message_to_display = None
        if command:
            #Clears the player profile should the player transition to the next room.
            def clear_player ():
                temp = list (room_data [now_y])
                temp [now_x] = " "
                room_data [now_y] = "".join (temp)
            #Movement options and following for moving up in the map
            if command.lower () == "w":
                target_y = now_y - 1
                if target_y >= 0:
                    #Find the target position and evaluate which option is executed according to the character in the target position
                    ch = room_data [target_y][now_x]
                    if ch == " " or ch == "D":
                        clear_player ()
                    if ch == " ":
                        now_y = target_y
                    elif ch == "D":
                        current_room, room_data, now_x, now_y, has_key = switch_room (rooms, current_room, now_x, target_y, "next", set_mode, has_key)
                    else: 
                        message_to_display = ""
                else:
                    message_to_display = ""
            #Movement options and following for moving down in the map  
            elif command.lower () == "s":
                target_y = now_y + 1
                if target_y < len (room_data):
                    #Find the target position and evaluate which option is executed according to the character in the target position
                    ch = room_data [target_y][now_x]
                    if ch == " " or ch == "D":
                        clear_player ()
                    if ch == " ":
                        now_y = target_y
                    elif ch == "D":
                        current_room, room_data, now_x, now_y, has_key = switch_room (rooms, current_room, now_x, target_y, "next", set_mode, has_key)
                    else:
                        message_to_display = ""
                else:
                    message_to_display = ""
            #Movement options and following for moving left in the map
            elif command.lower () == "a":
                target_x = now_x - 1
                if target_x >= 0:
                    ch = room_data [now_y][target_x]
                    #Find the target position and evaluate which option is executed according to the character in the target position
                    if ch == " " or ch == "D":
                        clear_player()
                    if ch == " ":
                        now_x = target_x
                    elif ch == "D":
                        current_room, room_data, now_x, now_y, has_key = switch_room (rooms, current_room, target_x, now_y, "prev", set_mode, has_key)
                    else:
                        message_to_display = ""
                else:
                    message_to_display = ""
            #Movement options and following for moving right in the map
            elif command.lower () == "d":
                target_x = now_x + 1
                if target_x < len (room_data [now_y]):
                    #Find the target position and evaluate which option is executed according to the character in the target position
                    ch = room_data [now_y][target_x]
                    if ch == " " or ch == "D":
                        clear_player ()
                    if ch == " ":
                        now_x = target_x
                    elif ch == "D":
                        current_room, room_data, now_x, now_y, has_key = switch_room (rooms, current_room, target_x, now_y, "next", set_mode, has_key)
                    else:
                        message_to_display = ""
                else:
                    message_to_display = ""
            #This is for defining interactions within the game which are opening doors and picking up keys.
            elif command.lower () == "i":
                interact_target_coords = None
                interact_target_char = None
                #Check all surrounding coordinates for possible interactions (door opening or key grabbing)
                for tx, ty in possible_target_coords:
                    ch = room_data [ty][tx]
                    if current_room == 6 and ch == "T":
                        interact_target_coords = (tx, ty)
                        interact_target_char = "T"
                        break
                    #Lists all possible interactions with the characters in the room and model the following interactions accordingly
                    if ch in ["T", "S", "C", "R", "M", "D"]:
                        interact_target_coords = (tx, ty)
                        interact_target_char = ch
                        break
                #Defining key objects which can be interacted with in game
                key_objects = {
                    0: 'T',
                    1: 'S',
                    2: 'C',
                    3: 'R',
                    4: 'M'
                }
                #Special case listing for exit with the trophy in the final room.
                if interact_target_char == "T" and current_room == 6:
                    clear_saved_position ()
                    os.system ("clear")
                    print ("You win!")
                    end_raw_mode (set_mode)
                    sys.exit ()
                #This is for if one were to attain the key in each room.
                elif interact_target_char == key_objects.get (current_room):
                    has_key = True
                    message_to_display = "Key Acquired"
                    tx, ty = interact_target_coords
                    temp = list (room_data [ty])
                    temp [tx] = " "
                    room_data [ty] = "".join (temp)
                #If the player does not have the key and tries to go through the door, they will be having a prtty bad time.
                elif interact_target_char == "D":
                    if current_room != 5 and not has_key:
                        message_to_display = "Key Required"
                    else:
                        clear_player ()
                        direction = "next" if interact_target_coords [0] > now_x else "prev"
                        #Loads the next room in case of crossing the door
                        current_room, room_data, now_x, now_y, has_key = switch_room (rooms, current_room, interact_target_coords [0], interact_target_coords [1], direction, set_mode, has_key)
                #For when the user tries to interact with nothing
                else:
                    message_to_display = "No interaction"
            #To quit the game when q is pressed
            elif command.lower () == "q":
                save_last_position (current_room, now_x, now_y)
                end_raw_mode (set_mode)
                print("Game saved. Goodbye!")
                break
            #When the user presses a key that is not part of the game
            else:
                message_to_display = "Invalid keybinding."
            temp = list (room_data [now_y])
            temp [now_x] = "!"
            room_data [now_y] = "".join (temp)
        os.system ("clear")
        #Prints the entire map as of the current state of the game
        for line in room_data:
            print (line)
        if message_to_display:
            print (message_to_display)
    #Ends the raw mode to exit the game
    end_raw_mode (set_mode)
main ()

