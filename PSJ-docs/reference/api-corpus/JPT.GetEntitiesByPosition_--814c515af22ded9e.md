# JPT.GetEntitiesByPosition()

JPT.GetEntitiesByPosition()

Description​

Get the entity satisfying the given conditions (X, Y, Z).

Syntax​

JPT.GetEntitiesByPosition(AssociateType, xCoordValue, yCoordValue, zCoordValue)

Inputs​

AssociateType​

An Enum specifying the AssociateType describing the association type in Jupiter.

This is a required input.

xCoordValue​

A Double specifying the value in X coordinate (Cartesian coordinate system).

This is a required input.

yCoordValue​

A Double specifying the value in Y coordinate (Cartesian coordinate system).

This is a required input.

zCoordValue​

A Double specifying the value in Z coordinate (Cartesian coordinate system).

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing the information of the satisfied entity.

Note that to get the satisfied entity, please get the second element of the created DItemVector.

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get the information of the created cube
selPart = JPT.GetEntitiesByPosition(JPT.AssociateType.AS_BODY, 10, 10, 10)
JPT.Debugger(selPart[1]) # second element of the created list
