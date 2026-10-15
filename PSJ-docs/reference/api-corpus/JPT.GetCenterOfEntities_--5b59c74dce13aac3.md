# JPT.GetCenterOfEntities()

JPT.GetCenterOfEntities()

Description​

Get center coordinate of selected entities.

Syntax​

JPT.GetCenterOfEntities(DItemVector)

Inputs​

DItemVector​

A DItemVector object or List of DItem objects specifying the targets to get center coordinates.

This is a required input.

Return Code​

A DoubleVector object or List of Double value containing the coordinate values [x, y, z] of the center of the inputted entities.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the center coordinate of the inputted entities
listParts = JPT.GetAllByTypeID(3)
JPT.Debugger(JPT.GetCenterOfEntities(listParts))
