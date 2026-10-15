# JPT.CastToDItem()

JPT.CastToDItem()

Description​

Convert the selected object to DItem object to get all the related information.

Syntax​

JPT.CastToDItem(Object)

Inputs​

Object​

An Object in Jupiter such as DBody, DFace, DElem, DEdge, DGroup, DNode, etc.

This is a required input.

Return Code​

A DItem object (Base object with all the information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get Part object as DBody object from the created list of DBody objects
listDBodyParts = JPT.GetAllParts()
dBodyPart = listDBodyParts[0]
JPT.Debugger(dBodyPart)

# Convert from the above DBody object to DItem object
dItemPart = JPT.CastToDItem(dBodyPart)
JPT.Debugger(dItemPart)
