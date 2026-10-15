# JPT.CastDItemToDGroup()

JPT.CastDItemToDGroup()

Description​

Convert DItem object to DGroup object to get the information of the selected group.

Syntax​

JPT.CastDItemToDGroup(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DGroup object (Group with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
JPT.ViewFitToModel()

# Get Group object as DItem object from the created list of DItem objects
listDItemGroups = JPT.GetAllByTypeID(JPT.DItemType.GROUP)
dItemGroup = listDItemGroups[0]
JPT.Debugger(dItemGroup)

# Convert from the above DItem object to DGroup object
dGroup = JPT.CastDItemToDGroup(dItemGroup)
JPT.Debugger(dGroup)
