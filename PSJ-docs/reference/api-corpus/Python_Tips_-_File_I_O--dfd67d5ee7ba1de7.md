# Python Tips - File I/O

Python Tips - File I/O

🎯 Introduction​

This document introduces the use of external files in Python with examples.

Basic operations

The case if characters garbled (character encoding)

String processing

CSV file processing

File path expressions and separators

Tips for obtaining files and folders (os module)

📖 Basic File Operations​

Loading an existing file.​

Prepare a Sample.txt file with the following contents under C:\Temp beforehand.

#Number,Type,ID,Value
1,Node,5,300
2,Node,6,800
3,Element,8,4.65

The open function in Python is used. 

Typical uses of the open function include the following

Prepare a variable that points to the contents of a file, and read and display it line by line with the readline function.

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    print(fr.readline())
    print(fr.readline())
    print(fr.readline())
    print(fr.readline())

The contents of the file are read and displayed line by line until the end with a for statement.

Filepath='C:/Temp/Sample.txt'
for line in open(Filepath,'r'):
    print(line)

Prepare a variable that points to the contents of the file, and read and display it line by line with the readline function.

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    while line := fr.readline():
        print(line)

Prepare a variable that points to the contents of the file, read multiple lines at once with resdlines, and display what is stored in the list.

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    print(fr.readlines())

Another way is to provide a variable that points to the contents of the file. In this case, you must explicitly close the file with close when you are finished reading it.

Filepath='C:/Temp/Sample.txt'
fr = open(Filepath,'r')
print(fr.readlines())
fr.close()

Write out to a new file​

Create MyNewFile.txt under C:\Temp and output the string.

Filepath='C:/Temp/MyNewFile.txt'
with open(Filepath,'w') as fw:
    fw.write('Export string: first line\n')
    fw.write('Export string: second line\n')

Appending to an existing file​

Append strings to the existing file MyNewFile.txt under C:\Temp

Filepath='C:/Temp/MyNewFile.txt'
with open(Filepath,'a') as fw:
    fw.write('Export string: third line\n')
    fw.write('Export string: fourth line\n')

📖 Character Codes and Garbled Characters​

When coding in Python, the character encoding of the operating system is used. For Japanese OS, Shift-JIS is used, and for English OS, UTF-8 is used. Therefore, if you have a problem with garbled characters when reading a file in Python, you can specify the encoding with "encoding" when opening the file to avoid garbled characters.

*This problem mainly happens only if you use wide characters.

import os
Folder = 'C:/Temp'
#エンコードUTF-8のファイル
File = 'UTF-8.txt'
path = os.path.join(Folder, File)
for line in open(path,'r',encoding='utf8'):
    print(line)

📖 String Processing​

When a string from a file is read, even line breaks and whitespace before and after the string are read as is. Python has many useful string processing functions. Here are some of them.

import os
for line in open('C:/Temp/Sample.txt','r'):
    #Skip readline if the string contains "Element"
    if 'Element' in line:
        continue
    #Remove consecutive whitespace characters (full/half-width spaces, tabs, line feeds) before and after a string
    line_correct=line.strip()
    #Replace the specified character (replacing it with a space character will result in deletion)
    plane_line=line_correct.replace('#','')
    #Split string with comma as delimiter and input into list
    data=plane_line.split(',')
    print(data)

📖 File Path Separator​

When expressing a file path in Python code, the path separator is the "/" (slash) character. In Windowsv OS, the "\" (backslash or "￥")is used to express a path separator, but this symbol is considered a special character in Python code, so you need to change it to one of the following notations.

#Separater of python.
Filepath='C:/Temp/MyFile.txt'

#The backslash is used as a file path separator by writing the special character backslash twice.
Filepath='C:\\Temp\\MyFile.txt'

#Use Windows file path delimiters with raw strings.
Filepath=r'C:\Temp\MyFile.txt'
#In this notation, a backslash cannot be used at the end of a path because the ' at the end of a line cannot be recognized as a special character.
#NG example
#Folderpath=r'C:\Temp\'

📖 File path concatenation​

Since file paths are strings, you can use the union of strings when concatenating file paths, but
To safely concatenate file paths, it is recommended to import the os module and use the os.path.join() function. For example, the following can be used without error by adding the path separator used by each OS in the appropriate position.

import os
Folder = 'C:/Temp'
File = 'Sample.txt'
path = os.path.join(Folder, File)
print(path)

📖 os module​

The os module is a python module for using os-dependent functions and has a number of functions that are particularly useful for file and folder manipulation.
Here are some examples of common uses.

#use os module
import os

#Confirm existence of paths (files/folders)
isExists=os.path.exists(r'C:\Temp\MyFile.txt')
print(isExists)

#Determines if the specified path is a file - Used to check for the existence of a file
isFile=os.path.isfile(r'C:\Temp\Sample.txt')
print(isFile)

#Determines if the specified path is a folder - Used to confirm the existence of a folder
isDir=os.path.isdir(r'C:\Temp')
print(isDir)

#Store files in the specified folder in a list
fileList=os.listdir('C:\Temp')
for file in fileList:
    print(file)

#Get folder/file tree under the specified folder
for currFolder,folders,files in os.walk('C:\Temp'):
    print(currFolder)
    print(folders)
    print(files)
