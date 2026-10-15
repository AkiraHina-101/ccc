# JPT.IsSpatialPointRendered()

JPT.IsSpatialPointRendered()

Description​

Check if a specified point (node) that has the spatial coordinates (X, Y, Z) is rendered in the current view.

Syntax​

JPT.IsSpatialPointRendered(posX, posY, posZ)

Inputs​

posX​

A Double specifying the X coordinate of the specified point (node).

This is a required input.

posY​

A Double specifying the Y coordinate of the specified point (node).

This is a required input.

posZ​

A Double specifying the Z coordinate of the specified point (node).

This is a required input.

Return Code​

A Boolean specifying the status of the specified point (node):

True: The specified point (node) can be rendered.

False: The specified point (node) is hidden.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6974164)
JPT.ViewFitToModel()

# Select a node with ID = 7
JPT.SelectionByID(JPT.DItemType.NODE, 7, True)
listSelNodes = JPT.GetSelectedNodes()

# Check if the selected node is rendered
result=JPT.IsSpatialPointRendered(listSelNodes[0].pos.x, listSelNodes[0].pos.y, listSelNodes[0].pos.z)
print(result)
