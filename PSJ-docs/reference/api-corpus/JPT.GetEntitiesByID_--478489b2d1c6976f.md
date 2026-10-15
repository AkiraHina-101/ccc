# JPT.GetEntitiesByID()

JPT.GetEntitiesByID()

Description​

Get information of the inputted entity ID.

Syntax​

JPT.GetEntitiesByID(DItemType, itemID)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

itemID​

An Integer specifying the ID of the target entity.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing the information of the entity has the inputted ID.

Note that the inputted entity is the first element of this list.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of the part with ID = 2 and store it to a list
listParts = JPT.GetEntitiesByID(JPT.DItemType.BODY, 2)

# Print the information of the part
JPT.Debugger(listParts[0])
