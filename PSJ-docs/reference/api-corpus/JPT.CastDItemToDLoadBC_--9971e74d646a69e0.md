# JPT.CastDItemToDLoadBC()

JPT.CastDItemToDLoadBC()

Description​

Convert DItem object to DLoadBC object to get the information of the selected coordinate system.

Syntax​

JPT.CastDItemToDLoadBC(DItemObject)

Inputs​

DItemObject​

A DItem object which will be used to convert.

This is a required input.

Return Code​

A DLoadBC object (Boundary condition with relating information).

Sample Code​

# Prepare simple sample
Geometry.Part.Cube(iPartColor=6409934)
BoundaryConditions.Pressure.General(crlTargets=[Face(26)])
JPT.ViewFitToModel()

# Get LBC object (Pressure) as DItem object from the created list of DItem objects
listDItemLoadBCs = JPT.GetAllByTypeID(JPT.DItemType.LBC_G_PRESSURE)
dItemLoadBC = listDItemLoadBCs[0]
JPT.Debugger(dItemLoadBC)

# Convert from the above DItem object to DLoadBC object
dLoadBC = JPT.CastDItemToDLoadBC(dItemLoadBC)
JPT.Debugger(dLoadBC)
