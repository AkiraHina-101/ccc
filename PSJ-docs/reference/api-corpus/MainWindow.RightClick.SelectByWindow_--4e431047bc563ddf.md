# MainWindow.RightClick.SelectByWindow()

MainWindow.RightClick.SelectByWindow()

Description​

Select all targets of the same type as the specified one that is displaying the working window region.

Syntax​

MainWindow.RightClick.SelectByWindow(...)

Macro: ViewSelectByWindow

Ribbon: MainWindow » RightClick » SelectByWindow

Inputs​

iTargetType​

An Integer specifying the target type to be selected.

This is a required input.

Return Code​

A List of Cursor specifying the selected faces or 2D elements

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# Select on displaying faces  
displayFaces = MainWindow.RightClick.SelectByWindow(iTargetType=3)
if displayFaces is None:
    print("There is no face on current window")
elif len(displayFaces) == 1:
    print("1 displaying face was selected")
    print(displayFaces)
else:
    print(str(len(displayFaces)) + " displaying faces were selected")
    print(displayFaces)
