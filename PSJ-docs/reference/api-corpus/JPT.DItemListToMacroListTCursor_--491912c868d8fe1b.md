# JPT.DItemListToMacroListTCursor()

JPT.DItemListToMacroListTCursor()

Description​

Convert DItemVector object or List of DItem objects to List of Cursor (Macro string type).

Syntax​

JPT.DItemListToMacroListTCursor(DItemList)

Inputs​

DItemList​

A DItemVector object or a List of DItem objects to be converted.

This is a required input.

Return Code​

A String containing all the converted items.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get all the existing faces and convert them to List of Cursor (Macro string type)
## Get all Faces from model
listFaces = [JPT.CastToDItem(face) for face in JPT.GetAllFaces()] # List of DItem objects
## Return Faces to a string object, for example, return value = [6:73, 6:74, ...]
JPT.Debugger(JPT.DItemListToMacroListTCursor(listFaces))
