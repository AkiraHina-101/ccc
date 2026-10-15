# MainWindow.RightClick.SelectAll()

MainWindow.RightClick.SelectAll()

Description​

Select all faces or shell elements according to the specified target type.

Syntax​

MainWindow.RightClick.SelectAll(...)

Macro: ViewSelectAll

Ribbon: MainWindow » RightClick » SelectAll

Inputs​

iTargetType​

An Integer specifying the target type to be selected. The target can be face or 2D element only.

This is a required input.

Return Code​

A List of Cursor specifying the selected targets.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# Select all faces
listFaces = MainWindow.RightClick.SelectAll(iTargetType=3)
print(listFaces)

# Select all 2D elements
listElems= MainWindow.RightClick.SelectAll(iTargetType=7)
print(listElems)
