import os
if os.path.exists ("folder"):
    os.rmdir ("folder")
    print ("Folder successfully removed.")
else :
    print ("Folder not found in file system. Errno -1.")
