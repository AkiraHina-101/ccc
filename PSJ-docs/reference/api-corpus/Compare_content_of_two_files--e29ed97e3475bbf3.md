# Compare content of two files

Compare content of two files

🎯 Introduction​

In this tutorial, you'll learn how to compare content of two files (log files, output files, etc.):

Get path of installed Jupiter.

Set the path of two files which their content will be compared.

Compare content of two files.
Then display the comparison result (same or different) in Python API window.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Import file compare module 'filecmp'
import filecmp

# Get path of installed Jupiter
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)

# Set the path of two files which their content will be compared.
myPath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/Utils'
file1 = myPath + '/FileCompare1.txt'
file2 = myPath + '/FileCompare2.txt'

# Compare content of two files. Display the comparison information at Python API window.
is_same_file = filecmp.cmp(file1,file2)
if is_same_file == 0:
   print('Content of two files is different')
else:
   print('Content of two files is same')
