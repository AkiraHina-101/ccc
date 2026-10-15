# MainWindow.RightClick.SelectDisplayed()

MainWindow.RightClick.SelectDisplayed()

Description​

Select all targets of the same type as the specified target that are displayed in the current document.

Syntax​

MainWindow.RightClick.SelectDisplayed(...)

Macro: ViewSelectDisplayed

Ribbon: MainWindow » RightClick » SelectDisplayed

Inputs​

iTargetType​

An Integer specifying the target type to be selected. The targets can only be faces or 2D elements.

This is a required input.

Return Code​

A List of Cursor specifying the selected faces or 2D elements.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# Hide some faces
JPT.Exec("Show_Entity([6:52, 6:78], 0)")

# Select on displaying faces
displayFaces = MainWindow.RightClick.SelectDisplayed(iTargetType=3)
if displayFaces is None:
    print("There is no displaying faces")
elif len(displayFaces) == 1:
    print("1 displaying face was selected")
    print(displayFaces)
else:
    print(str(len(displayFaces)) + " displaying faces were selected")
    print(displayFaces)
