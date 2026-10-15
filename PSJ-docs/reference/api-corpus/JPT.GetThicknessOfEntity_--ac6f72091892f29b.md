# JPT.GetThicknessOfEntity()

JPT.GetThicknessOfEntity()

Description​

Get thickness of the inputted entity ID (Available for Part/Face/Element only).

Syntax​

JPT.GetThicknessOfEntity(DItemType, entityID)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

entityID​

An Integer specifying the ID of Part/Face/Element.

This is a required input.

Return Code​

A Double specifying the thickness of the target entity.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=6149981)
Properties.Material.Add(strMaterialName="Structural_Steel", listMaterialProperty=[Density([(DENSITY, 7.85e-09)]), Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
Properties.Shell(crlTargets=[Face(26)], strName="Shell Property 1", iPropertyColor=16131973, crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), dMatOrient1=DFLT_DBL, dThickness=0.005, dBendStiff=DFLT_DBL, dThickRatio=DFLT_DBL, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Face(52)], strName="Shell Property 2", iPropertyId=2, iPropertyColor=7010958, crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), dMatOrient1=DFLT_DBL, dThickness=0.01, dBendStiff=DFLT_DBL, dThickRatio=DFLT_DBL, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Face(22)], strName="Shell Property 3", iPropertyId=3, iPropertyColor=3962802, crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), dMatOrient1=DFLT_DBL, dThickness=0.015, dBendStiff=DFLT_DBL, dThickRatio=DFLT_DBL, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Face(48)], strName="Shell Property 4", iPropertyId=4, iPropertyColor=6396734, crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), dMatOrient1=DFLT_DBL, dThickness=0.02, dBendStiff=DFLT_DBL, dThickRatio=DFLT_DBL, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iItgPts=DFLT_INT)
JPT.ViewFitToModel()

#Get all the existing connections
dThickness_1 = JPT.GetThicknessOfEntity(JPT.DItemType.FACE,26)
dThickness_2 = JPT.GetThicknessOfEntity(JPT.DItemType.FACE,52)
dThickness_3 = JPT.GetThicknessOfEntity(JPT.DItemType.FACE,22)
dThickness_4 = JPT.GetThicknessOfEntity(JPT.DItemType.FACE,48)
JPT.Debugger(dThickness_1)
JPT.Debugger(dThickness_2)
JPT.Debugger(dThickness_3)
JPT.Debugger(dThickness_4)
