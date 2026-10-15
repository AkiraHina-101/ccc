# JPT.HighlightByID()

JPT.HighlightByID()

Description​

Highlight an item in Assembly tree by using its DItemType and its ID.

Syntax​

JPT.HighlightByID(DItemType, entityID, BoolType)

Inputs​

DItemType​

An Enum specifying DItemType of the target entities.

This is a required input.

entityID​

An Integer specifying ID of the selecting entity.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the selection mode:
True: Select the inputted entity with its ID.

False: Deselect the inputted entity with its ID.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# Create LBCs
BoundaryConditions.Pressure.General(dPressure=100000000.0, crlTargets=[Face(26)])
BoundaryConditions.Force.General(forceLBC=FORCE_LBC(vecForce=[DFLT_DBL, DFLT_DBL, -10.0]), 
    crlTargets=[Face(52)])
BoundaryConditions.FixedConstraint(crlTargets=[Face(77, 51, 25)])

# Highlight Pressure item in Assembly tree
listDItemLoadBCs = JPT.GetAllLoadsBCs()
for lbc in listDItemLoadBCs:
    if lbc.type == JPT.DItemType.LBC_G_PRESSURE:
        iID = lbc.id
JPT.HighlightByID(JPT.DItemType.LBC_G_PRESSURE, iID, JPT.BoolType.TRUE_VAL)
