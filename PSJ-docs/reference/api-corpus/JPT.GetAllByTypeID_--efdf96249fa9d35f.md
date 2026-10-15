# JPT.GetAllByTypeID()

JPT.GetAllByTypeID()

Description​

Get all the information of all entities by inputting DItemType.

Syntax​

JPT.GetAllByTypeID(DItemType)

Inputs​

DItemType​

An Enum specifying DItemType of the target entities.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing all the information of all the found entities by inputted ID.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Select all parts and store their information to a list of DItem
listDItemParts = JPT.GetAllByTypeID(JPT.DItemType.BODY) # ID = 3
JPT.Debugger(listDItemParts)
