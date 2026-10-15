# MainWindow.RightClick.SelectReverse()

MainWindow.RightClick.SelectReverse()

Description​

Reverse the selection on the displaying bodies.

Syntax​

MainWindow.RightClick.SelectReverse(...)

Macro: ViewSelectReverse

Ribbon: MainWindow » RightClick » SelectReverse

Inputs​

iTargetType​

An Integer specifying the target type to select entities in reverse. The targets can only be faces or 2D elements.

This is a required input.

crlTargets​

A List of Cursor specifying the targets will reverse the selection.

The default value is [].

Return Code​

A List of Cursor specifying the selected entities in revert.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# Revert selection from Face(26)
revertFaces = MainWindow.RightClick.SelectReverse(iTargetType=3, crlTargets=[Face(26)])
print(revertFaces)
