# JPT.CastDItemToDROElem()

JPT.CastDItemToDROElem()

Description​

Convert DItem object to DPostElem object to get the information of the selected Post element.

Syntax​

JPT.CastDItemToDROElem(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DPostElem object (Post element with relating information).

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# Get Element object as DItem object from the created list of DItem objects
listDItemPostElems = JPT.GetAllByTypeID(JPT.DItemType.POST_ELEM)
dItemPostElem = listDItemPostElems[0]
JPT.Debugger(dItemPostElem)

# Convert from the above DItem object to DElem object
dPostElem = JPT.CastDItemToDROElem(dItemPostElem)
JPT.Debugger(dPostElem)
