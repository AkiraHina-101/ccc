# JPT.CastDItemToDBody()

JPT.CastDItemToDBody()

Description​

Convert DItem object to DBody object to get the information of the selected body.

Syntax​

JPT.CastDItemToDBody(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DBody object (Part with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get Part object as DItem object from the created list of DItem objects
listDItemParts = JPT.GetAllByTypeID(JPT.DItemType.BODY)
dItemPart = listDItemParts[0]
JPT.Debugger(dItemPart)

# Convert from the above DItem object to DBody object
dBodyPart = JPT.CastDItemToDBody(dItemPart)
JPT.Debugger(dBodyPart)
