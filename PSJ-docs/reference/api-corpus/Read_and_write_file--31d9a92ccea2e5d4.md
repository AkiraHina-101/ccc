# Read and write file

Read and write file

🎯 Introduction​

In this tutorial, you'll learn how to read and write file with PSJ-Utility:

Set path of file for reading/writing.

Check the existing of file.

Read file content with different purpose: line by line directly/ whole file / specific characters.

Write content to file with append or write option.

Please prepare the text file in local disk to use the code in sample.

Administration rights can be an issue when reading/writing file to C:/ drive, be noticed.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Set path of file, it must be an existed file
myFile = 'D:/myFile.txt'

# Check file exist or not. If not exist, display information at Python API window.
import os.path
if not os.path.exists(myFile):
    print("file is not exist!")

# Prepare the text file in local disk to use the below code
########## Read file ##########
# Read line by line. Display content at Python API window.
file = open(myFile, "r")
for line in file:
  print(line)
file.close()

# Read whole content of file. Display content at Python API window.
file = open(myFile, "r")
print(file.read())
file.close()

# Read first 4 characters of file. Display content at Python API window.
file = open(myFile, "r")
print(file.read(4))
file.close()

########## Write file ##########
# Append 'a' content at the end of file
file = open(myFile, "a")
file.write("\nAdd new line, write new content")
file.close()

# Read 'r' whole content of file after appending. Display content at Python API window.
file = open(myFile, "r")
print(file.read())
file.close()

# Write 'w' content to file. Create a new file if file does not exist
file = open(myFile, "w")
file.write("Existing content of file is deleted. New content is overwritten")
file.close()

# Read 'r' whole content of file after overwrite. Display content at Python API window.
file = open(myFile, "r")
print(file.read())
file.close()
