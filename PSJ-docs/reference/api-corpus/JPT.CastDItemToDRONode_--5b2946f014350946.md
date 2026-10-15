# JPT.CastDItemToDRONode()

JPT.CastDItemToDRONode()

Description​

Convert DItem object to DPostNode object to get the information of the selected Post node.

Syntax​

JPT.CastDItemToDRONode(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DPostNode object (Post node with relating information).

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# Get LBC object (Pressure) as DItem object from the created list of DItem objects
listDItemPostNodes = JPT.GetAllByTypeID(JPT.DItemType.POST_NODE)
dItemPostNode = listDItemPostNodes[0]
JPT.Debugger(dItemPostNode)

# Convert from the above DItem object to DPostNode object
dPostNode = JPT.CastDItemToDRONode(dItemPostNode)
JPT.Debugger(dPostNode)
