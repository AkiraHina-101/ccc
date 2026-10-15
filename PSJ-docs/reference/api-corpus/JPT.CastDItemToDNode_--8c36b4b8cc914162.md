# JPT.CastDItemToDNode()

JPT.CastDItemToDNode()

Description​

Convert DItem object to DNode object to get the information of the selected node.

Syntax​

JPT.CastDItemToDNode(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DNode object (Node with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get LBC object (Pressure) as DItem object from the created list of DItem objects
listDItemNodes = JPT.GetAllByTypeID(JPT.DItemType.NODE)
dItemNode = listDItemNodes[0]
JPT.Debugger(dItemNode)

# Convert from the above DItem object to DNode object
dNode = JPT.CastDItemToDNode(dItemNode)
JPT.Debugger(dNode)
