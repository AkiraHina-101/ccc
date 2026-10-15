# JPT.GetAllLoadsBCs()

JPT.GetAllLoadsBCs()

Description​

Get all the information of all existing loads and boundary conditions under DItemVector format.

Syntax​

JPT.GetAllLoadsBCs()

Inputs​

This utility function does not require any input value.

Return Code​

A DItemVector object or List of DItem objects containing all the information of all the existing loads and boundary conditions.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.024, 0.0, 0.0], strName="Cube_3", iPartColor=7697908)
BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])
BoundaryConditions.Pressure.General(crlTargets=[Face(52)])
JPT.ViewFitToModel()

# Get the information of all existing loads and boundary conditions
listDItemLoadBCs = JPT.GetAllLoadsBCs()
JPT.Debugger(listDItemLoadBCs)

# Print all the related information of each existing load/boundary condition in list
for lbc in listDItemLoadBCs:
    JPT.Debugger(lbc)
