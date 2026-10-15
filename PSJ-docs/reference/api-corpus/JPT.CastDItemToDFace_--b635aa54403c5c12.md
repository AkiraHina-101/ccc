# JPT.CastDItemToDFace()

JPT.CastDItemToDFace()

Description​

Convert DItem object to DFace object to get the information of the selected (Inputted) face(s).

Syntax​

JPT.CastDItemToDFace(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DFace object (Face with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get Face object as DItem object from the created list of DItem objects
listDItemFaces = JPT.GetAllByTypeID(JPT.DItemType.FACE)
dItemFace = listDItemFaces[0]
JPT.Debugger(dItemFace)

# Convert from the above DItem object to DFace object
dFace = JPT.CastDItemToDFace(dItemFace)
JPT.Debugger(dFace)
