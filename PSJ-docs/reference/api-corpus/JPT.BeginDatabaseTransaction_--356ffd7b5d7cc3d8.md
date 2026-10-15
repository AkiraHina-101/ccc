# JPT.BeginDatabaseTransaction()

JPT.BeginDatabaseTransaction()

Description​

Disable screen animation, screen update, and status bar update information to improve Jupiter's performance.

important

JPT.EndDatabaseTransaction() should be used at the end of the process, to return Jupiter to the normal state.

Syntax​

JPT.BeginDatabaseTransaction("transactionName")

Inputs​

transactionName​

A String specifying the transaction name (used to display the command name in Undo/Redo menu).

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Begin Data Base Transaction
JPT.BeginDatabaseTransaction("Make meshed model")

# From now on, all the steps inside will be stored as one step - "Make meshed model".
# You can check it by clicking on the Undo button after the execution process is finished.

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0],
                   strName="Cube_3",
                   iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0],
                   strName="Cube_4",
                   iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0],
                   strName="Cube_5",
                   iPartColor=7463537)
Geometry.Part.Cube(dlOrigin=[0.05, 0.0, 0.0],
                   strName="Cube_6",
                   iPartColor=7434735)
Geometry.Part.Cube(dlOrigin=[0.06, 0.0, 0.0],
                   strName="Cube_7",
                   iPartColor=14903267)
Geometry.Part.Cube(dlOrigin=[0.07, 0.0, 0.0],
                   strName="Cube_8",
                   iPartColor=15658599)

Meshing.SetMeshAttribute(crlParts=[Part(5, 6, 7, 8)],
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bOutputQuadMesh=True,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(5, 6, 7, 8)],
                       surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bOutputQuadMesh=True,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                                                iThreadNum=12)
MeshEdit.SurfaceMesh(crlParts=[Part(2, 4, 8, 6)])
Meshing.SolidMeshing(crlParts=[Part(8, 4, 7, 3)],
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)
Meshing.SolidMeshing(crlParts=[Part(4)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

del_faces = [208, 182, 178, 204, 206, 177, 203, 179, 205, 180]
extrude_faces = [207, 181]

Geometry.DeleteEntity.Face(crlFaces=[Face(*del_faces)])

HexModeling.Linear(crlFaces=[Face(*extrude_faces)],
                   dLength=0.01,
                   iLayer=2,
                   vecSweepDirection=[0.0,
                                      0.0,
                                      1.0],
                   iLinearMethod=4)

MeshEdit.SolidMesh(crlParts=[Part(8)])

# End Data Base Transaction
JPT.EndDatabaseTransaction()
