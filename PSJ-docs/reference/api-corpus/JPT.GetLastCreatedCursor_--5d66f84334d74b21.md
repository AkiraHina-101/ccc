# JPT.GetLastCreatedCursor()

JPT.GetLastCreatedCursor()

Description​

Get the information of the last created entity.

Syntax​

JPT.GetLastCreatedCursor()

Inputs​

This utility function does not require any input value.

Return Code​

A DItemVector object or List of DItem objects containing the information of the last created object.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of the last created part
lastCreatedCursor = JPT.GetLastCreatedCursor()
JPT.Debugger(lastCreatedCursor[0]) # Cube_3
