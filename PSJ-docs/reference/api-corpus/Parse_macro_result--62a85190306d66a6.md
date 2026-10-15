# Parse macro result

Parse macro result

🎯 Introduction​

In this tutorial, you'll learn how to parse macro result returned from Jupiter Macro:

Create sample string which is returned result from macro.

Create a cube.

Create a String Vector containing parser pattern.

Introduce two methods to parse string result.

Introduce how to convert return result from macro to Jupiter database object.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Sample return result from macro
sampleReturn = '"string", 3:1, 10:210-10:202, [10:210-10:202, 10:316-10:308],  \
    [10:210, 10:202, 10:316 ,10:308], [[10:210], [10:210, 10:202], [10:316 ,10:308]], \
    ["string1", "string2", "string3"], [1,2,3], [1,2,3,4,5,6], 0.12345'

# Create a cube
Geometry.Part.Cube(strName="Cube_1", iPartColor=12999622)
JPT.ViewFitToModel()

# Create a String Vector containing parser pattern. Example: "string", "number", "list_cursor"
# *********************************************************************************************
# Below is example of String Data Rules for parser pattern:
# string : "string example"
# cursor : 3:1
# cursor_pair : 10:210-10:202
# list_cursor_pair : [10:210-10:202, 10:316-10:308]
# list_cursor : [10:210, 10:202, 10:316 ,10:308]
# list_list_cursor : [[10:210], [10:210, 10:202], [10:316 ,10:308]]
# list_string : ["string1", "string2", "string3"]
# vector3d : [1,2,3]
# list_number : [1,2,3,4,5,6]
# number : 0.12345
# *********************************************************************************************
ArgPatterns = JPT.StringVector()
ArgPatterns.append("string")
ArgPatterns.append("cursor")
ArgPatterns.append("cursor_pair")
ArgPatterns.append("list_cursor_pair")
ArgPatterns.append("list_cursor")
ArgPatterns.append("list_list_cursor")
ArgPatterns.append("list_string")
ArgPatterns.append("vector3d")
ArgPatterns.append("list_number")
ArgPatterns.append("number")

# There are two methods to parse string result

# Method1
listArgs1 = JPT.MacroResultParser(sampleReturn, ArgPatterns)
JPT.Debugger(listArgs1)

# Method2
listArgs2 = JPT.MacroResultParser(sampleReturn, ["string", "cursor", "cursor_pair", "list_cursor_pair",
    "list_cursor", "list_list_cursor", "list_string", "vector3d", "list_number", "number"])
JPT.Debugger(listArgs2)

# Convert return result from macro to DItem database object
cursor = JPT.MacroTCursorToDItem(listArgs2[1])
print ("cursor type: {}, cursor id: {}".format(str(cursor.type),str(cursor.id)))

# Convert return result from macro to DItemPair database object
ditemPair = JPT.MacroTCursorPairToDItemPair(listArgs2[2])
print("First Ditem | type: {}  id: {}".format(ditemPair.firstDItem.type,ditemPair.firstDItem.id))
print("Second Ditem | type: {}, id: {}".format(ditemPair.secondDItem.type,ditemPair.secondDItem.id))

# Convert return result from macro to list DItemPair database object
listditemPair = JPT.MacroListTCursorPairToListDItemPair(listArgs2[3])
if len(listditemPair) == 2:
    for i in range(len(listditemPair)):
        print("----------Ditem Pair: {}----------".format(i+1))
        print("First Ditem | type: {}  id: {}".
        format(listditemPair[i].firstDItem.type,listditemPair[i].firstDItem.id))
        print("Second Ditem | type: {}, id: {}".
        format(listditemPair[i].secondDItem.type,listditemPair[i].secondDItem.id))

# Convert return result from macro to list DItem database object
listDitem = JPT.MacroListTCursorToListDItem(listArgs2[4])
for Ditem in listDitem:
    print ("cursor type: {}, cursor id: {}".format(str(Ditem.type),str(Ditem.id)))

# Convert 'list_list_cursor' string from macro to list_cursor
listCursor = JPT.MacroResultParser(listArgs2[5][1:][:-1], ["list_cursor", "list_cursor", "list_cursor"])
print("List list cursor before conversion: {}".format(listArgs2[5]))
print("List cursor after conversion: {}".format(listCursor))
