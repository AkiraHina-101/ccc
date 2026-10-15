# MainWindow.RightClick.SelectByFace()

MainWindow.RightClick.SelectByFace()

Description​

Select all targets in the same plane as the selected targets.

Syntax​

MainWindow.RightClick.SelectByFace(...)

Macro: ViewSelectByFace

Ribbon: MainWindow » RightClick » SelectByFace

Inputs​

iTargetType​

An Integer specifying the target type to be selected.

This is a required input.

crlTargets​

A List of Cursor specifying the targets to select other targets in the same plane as them. The target can only be face or 2D element.

The default value is [].

Return Code​

A List of Cursor specifying the selected targets (faces or 2D elements)

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[49, 24, 50, 75], dTolerance=0.0001, \
                        iTypeConnectPos=0, bFitEdge=True)

# Select all faces in the same plane as the specified face
listFaces = MainWindow.RightClick.SelectByFace(iTargetType=3, crlTargets=[Face(26)])
if listFaces is None:
    print("There is no selected faces")
elif len(listFaces) == 1:
    print("One face was selected")
    print(listFaces)
else:
    print(str(len(listFaces)) + " faces were selected")
    print(listFaces)
