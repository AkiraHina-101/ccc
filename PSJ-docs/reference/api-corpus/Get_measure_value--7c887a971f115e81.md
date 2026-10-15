# Get measure value

Get measure value

🎯 Introduction​

In this tutorial, you'll learn how to measure area value, write content of Python API log to a file for backup:

Get list of all parts in current model.

Looping through each part of all parts list, then display id, name, area of each part at Python API window.

Write log content of Python API window to a file for backup.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create 3 cubes with different size.
Geometry.Part.Cube(dlOrigin=[0.00, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], strName="Cube_1", iPartColor=12999622)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.02, 0.01, 0.01], strName="Cube_2", iPartColor=5093709)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], dlLength=[0.03, 0.01, 0.01], strName="Cube_3", iPartColor=6118877)

# Fit view of model on display view
JPT.ViewFitToModel()

# Get list of all parts in current model
listAllPart = JPT.GetAllParts()

# Looping through each part of all parts list. Display id, name, area of part at Python API window
print("Part ID |" + "Part Name |" + "Part Area" )
for part in listAllPart:
    partDItem = JPT.CastToDItem(part)
    cursorPart = JPT.DItemToMacroListTCursor(partDItem)
    # Measure area of part.
    partArea = Tools.Measure.Area.Part(crlParts=cursorPart)
    print(str(part.id) + " | " + part.name + " | " + partArea)

# Get log message of Python API window. Write log content to a file
log = JPT.GetPythonAPILog()
file = open("D:/PythonAPI.log", "w")
for line in log:
    file.write(line)
file.close()
