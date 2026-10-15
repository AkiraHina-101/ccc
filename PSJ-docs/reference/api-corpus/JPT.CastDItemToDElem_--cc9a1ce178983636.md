# JPT.CastDItemToDElem()

JPT.CastDItemToDElem()

Description​

Convert DItem object to DElem object to get the information of the selected element.

Syntax​

JPT.CastDItemToDElem(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DElem object (Element with relating information).

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get Element object as DItem object from the created list of DItem objects
listDItemElems = JPT.GetAllByTypeID(JPT.DItemType.ELEM)
dItemElem = listDItemElems[0]
JPT.Debugger(dItemElem)

# Convert from the above DItem object to DElem object
dElem = JPT.CastDItemToDElem(dItemElem)
JPT.Debugger(dElem)
