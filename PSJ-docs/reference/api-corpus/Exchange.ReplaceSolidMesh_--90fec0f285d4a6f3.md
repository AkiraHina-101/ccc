# Exchange.ReplaceSolidMesh()

Exchange.ReplaceSolidMesh()

Description​

Replace an adjacent solid part.

Syntax​

Exchange.ReplaceSolidMesh(...)

Macro:

Ribbon: Exchange » ReplaceSolidMesh

Inputs​

crlSourceFace​

A List of Cursor specifying source face (base model side).

This is a required input.

crlTargetFace​

A List of Cursor specifying target face (echange part side).

This is a required input.

dTolerance​

A Double specifying tolerance between source face and target face.

This is a required input.

Return Code​

A Boolean specifying the function successfully executed or not.

Sample Code​

Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(
    dlOrigin=[0.01, 0.0, 0.0],
    ilAxialNodes=[4, 4, 4],
    strName="Cube_3",
    iPartColor=12867524)

Meshing.SolidMeshing(crlParts=[Part(1,2)],
    bTet10=True,
    dGradingFactor=1.05,
    dStretchLimit=0.1,
    iSpeedVsQual=1,
    iRegion=1,
    bSafeMode=False,
    iParallel=16,
    bInternalMeshOnly=False,
    iPartColor=65280)

ret=Exchange.ReplaceSolidMesh(
    crlSourceFace=[Face(24)],
    crlTargetFace=[Face(49)],
    dTolerance=0.0005)
