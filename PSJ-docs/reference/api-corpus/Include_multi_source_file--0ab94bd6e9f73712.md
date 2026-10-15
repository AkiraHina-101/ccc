# Include multi source file

Include multi source file

🎯 Introduction​

In this tutorial, you'll learn how to include external Python source files into current script:

Get installed Jupiter path.
Build up a folder path containing external Python source files.

Append path of external Python source file to system path.

Import all external Python source files (module): Sorts.py and JPTModule.py.

Create a cube (for testing external Python source file: JPTModule.py).

Test usability of imported modules inside Jupiter IDE.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get installed Jupiter path. Build up a folder path containing external Python source files
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
sourcePath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/Utils'
print(sourcePath)

# Append sourcePath to system path
import sys
sys.path.append(sourcePath)

# Import all external Python source files (module): Sorts.py and JPTModule.py
# Sorts.py is a Python file containing Sorting Algorithms
# JPTModule.py is a Python file containing PSJ Utility code
from Sorts import *
from Logger import *
from JPTModule import *

# Create a cube for testing external Python source file: JPTModule.py
Geometry.Part.Cube(strName="Cube_1", iPartColor=12999622)

# Test usability of imported modules inside Jupiter IDE

# Test usability of Sorts.py
originList = [3,2,1]
print("Origin List: {}".format(originList))
SortList = SortAlgorithms(originList).bubble_sort()
print("Sorted List: {}".format(SortList))

# Test usability of Logger.py
logFile = 'D:file.log'
PrintFile.print_file(logFile, "this is test string")

# Test usability of JPTModule.py
listParts = GetAllPartsWrapper()
JPT.Debugger(listParts)
