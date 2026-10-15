# Create group from CSV

Create group from CSV

🎯 Introduction​

In this tutorial, you'll learn how to create a group of elements by using a CSV template file:

Read content from csv file (contains element IDs) line by line.

Create a group of elements from the csv file.

Please prepare the text csv file with ID of elements in local disk to use the code in sample.

📖 Tutorial​

# Import 'exists' from module 'os.path'
import os
# Import 'csv'
import csv

# Clear the log message in Python API window
JPT.ClearLog()

# Prepare a cube
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 12999622, 0:0)')

# Declare path name of csv file
listElems = []
strJupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
fileCSV = strJupiterPath + '/SampleData/PSJ/PSJ-Utility/Utils/ElementID.csv'

# Read content from csv file (contains element IDs) line by line
if os.path.exists(fileCSV):
    with open(fileCSV) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            elemID = row[0]
            listElems.append(Elem((elemID)))
else:
    print("File does not exist!")

# Create a group of elements from the csv file
Tools.Group.CreateGroup(strGroupName="Group_Element", crlTargets=listElems)
