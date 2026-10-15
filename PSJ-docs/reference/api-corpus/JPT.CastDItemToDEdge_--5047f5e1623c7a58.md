# JPT.CastDItemToDEdge()

JPT.CastDItemToDEdge()

Description​

Convert DItem object to DEdge object to get the information of the selected edge.

Syntax​

JPT.CastDItemToDEdge(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DEdge object (Edge with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get Edge object as DItem object from the created list of DItem objects
listDItemEdges = JPT.GetAllByTypeID(JPT.DItemType.EDGE)
dItemEdge = listDItemEdges[0]
JPT.Debugger(dItemEdge)

# Convert from the above DItem object to DEdge object
dEdge = JPT.CastDItemToDEdge(dItemEdge)
JPT.Debugger(dEdge)
