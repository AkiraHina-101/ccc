# Use entity list

Use entity list

🎯 Introduction​

In this tutorial, you'll learn how to use entity list:

Get list of parts entity has specific name with match option is enable, display size of part list.

Get list of parts entity has specific name with match option is disable, display size of part list.

Create new empty list, add part to new list from existing part lists.

Delete/Clear part(s) of part list.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create 3 cubes
Geometry.Part.Cube(dlOrigin=[0.0, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_1", iPartColor=12999622,  crLocalCoordinate=None)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_2", iPartColor=5093709,  crLocalCoordinate=None)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_3", iPartColor=6118877,  crLocalCoordinate=None)
JPT.ViewFitToModel()

# Get list of parts has name is "Cube_1" with match option is enable, this function will return an entity list
isNameMatch = 1
listPart1 = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube_1", isNameMatch)
# Check size of part entity list, display at Python API window if size is 1
if len(listPart1) == 1:
    print("there is one part in 'listPart1' with name '{}'".format(listPart1[0].name))

# Get list of parts has name is "Cube" with match option is disable, this function will return an entity list
isNameMatch = 0
listPart2 = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube", isNameMatch)
# Check size of part entity list, display at Python API window if sizes are 3
if len(listPart2) == 3:
    print("there are 3 parts in 'listPart2' with name '{0}','{1}','{2}'".\
        format(listPart2[0].name,listPart2[1].name,listPart2[2].name))

# Check if listPart2's entities contains listPart1's entity. If yes, display the information
if listPart1[0] in listPart2:
    print("listPart2's entities contains listPart1's entity")

# Create new empty list, add part of listPart1, listPart2 to new empty list. Display size of listPart3.
listPart3 = []
listPart3.append(listPart1[0])

for part in listPart2:
    listPart3.append(part)
print("listPart3's sizes are: {} ".format(len(listPart3)))

# Delete first part of listPart3. Display size of listPart3.
listPart3.pop(0)
print("listPart3's sizes are: {} ".format(len(listPart3)))

# Clear all parts of listPart3. Display size of listPart3.
listPart3.clear()
print("listPart3's size is: {} ".format(len(listPart3)))
