# JPT.GetSharedFaces()

JPT.GetSharedFaces()

Description​

Get all information of the shared faces.

Syntax​

JPT.GetSharedFaces(DItemVector)

Inputs​

DItemVector​

A DItemVector object or List of DItem objects to get the shared faces.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing all the information of all the shared faces.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6217822)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6908379)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=7138924)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=15753968)
JPT.ViewFitToModel()

# Create shared faces
JPT.Exec('AssembleFaceMatingStep([], [], [3:1, 3:2, 3:3, 3:4], 1e-05)')
JPT.Exec('AssembleFaceEx([49, 24, 50, 75, 101, 76], 1e-05, 0, 0)')

# Get the information of all shared faces
listParts = JPT.GetAllByType(JPT.DItemType.BODY)
listSharedFaces = JPT.GetSharedFaces(listParts)
JPT.Debugger(listSharedFaces)
