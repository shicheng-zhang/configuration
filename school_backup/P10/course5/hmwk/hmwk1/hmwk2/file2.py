def alphabetical ():
    text = open ("A1-cities_and_times.txt", "r")
    lines = text.readlines ()
    for x in range (len (lines)):
        for y in range (len (lines)):
            smaller = -1
            if len (lines [x]) >= len (lines [y]):
                smaller = len (lines [y])
            else:
                smaller = len (lines [x])
            start_letter = 0
            for z in range (smaller):
                if lines [x][z].lower () == lines [y][z].lower ():
                    start_letter += 1
                else:
                    break
            if start_letter == smaller:
                if y >= x:
                    if smaller == len (lines [y]):
                        temp = lines [y]
                        lines [y] = lines [x]
                        lines [x] = temp
                else:
                    if smaller == len (lines [x]):
                        temp = lines [y]
                        lines [y] = lines [x]
                        lines [x] = temp 
            else:
                if ord (lines [y][start_letter].lower ()) > ord (lines [x][z].lower ()):
                    temp = lines [y]
                    lines [y] = lines [x]
                    lines [x] = temp
    text.close ()
    text2 = open ("A1-cities_and_times.txt", "w")
    text2.writelines (lines)
def checkoutbooks ():
    book_file = open ("A1Q6.txt", "r")
    books = book_file.readlines ()
    target = ["The Great Gatsby", "To Kill a Mockingbird", "1984", "Moby Dick", "Pride and Prejudice", "War and Peace"]
    for book in books:
        for z in range (len (target)):
            if target [z].lower () in book.lower ():
                print (book)


