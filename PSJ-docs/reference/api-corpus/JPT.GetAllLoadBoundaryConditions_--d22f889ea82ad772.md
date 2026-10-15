# JPT.GetAllLoadBoundaryConditions()

JPT.GetAllLoadBoundaryConditions()

Description​

Get all the information of all existing loads and boundary conditions.

Syntax​

JPT.GetAllLoadBoundaryConditions()

Inputs​

This utility function does not require any input value.

Return Code​

A LoadBCVector object or List of DLoadBC objects containing all the information of all the existing loads and boundary conditions.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.024, 0.0, 0.0], strName="Cube_3", iPartColor=7697908)
BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])
BoundaryConditions.Pressure.General(crlTargets=[Face(52)])
JPT.ViewFitToModel()

# Get the information of all existing loads and boundary conditions
listDLoadBCs = JPT.GetAllLoadBoundaryConditions()
JPT.Debugger(listDLoadBCs)

# Print all the related information of each existing load/boundary condition in list
for lbc in listDLoadBCs:
    JPT.Debugger(lbc)
