# JPT.GetAllByTableTypeID()

JPT.GetAllByTableTypeID()

Description​

Get all the information of all entities by inputting DTableType.

Syntax​

JPT.GetAllByTableTypeID(DTableType)

Inputs​

DTableType​

An Enum specifying DTableType of the target entities.

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
listDTableParts = JPT.GetAllByTableTypeID(JPT.DTableType.DTABLE_BODY) # ID = 5
JPT.Debugger(listDTableParts)
