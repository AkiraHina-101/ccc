# JPT.GetEntitiesByAdjacent()

JPT.GetEntitiesByAdjacent()

Description​

Get List of Objects by adjacency based on the stop angle.

Syntax​

JPT.GetEntitiesByAdjacent(DItemType, entityID, angleValue)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

entityID​

An Integer specifying the ID of the starting entity.

This is a required input.

angleValue​

An Integer specifying the stop angle between entities for searching.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing all the information of found entities.

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get the faces relating to the face with ID = 26 based on angle = 30
adjacentFaces = JPT.GetEntitiesByAdjacent(JPT.DItemType.FACE, 26, 30)
JPT.Debugger(adjacentFaces)
