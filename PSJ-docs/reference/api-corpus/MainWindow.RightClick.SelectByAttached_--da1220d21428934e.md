# MainWindow.RightClick.SelectByAttached()

MainWindow.RightClick.SelectByAttached()

Description​

Select all attachments from the specified targets

Syntax​

MainWindow.RightClick.SelectByAttached(...)

Macro: ViewSelectByAttached

Ribbon: MainWindow » RightClick » SelectByAttached

Inputs​

iTargetType​

An Integer specifying the target type to be selected.

This is a required input.

crlTargets​

A List of Cursor specifying the targets to select the attached ones from them. The target can only be face or 2D element.

This is a required input.

Return Code​

A List of Cursor specifying the selected targets (faces or 2D elements).

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# Select on displaying faces  
attachFaces = MainWindow.RightClick.SelectByAttached(iTargetType=3, crlTargets=[Face(26)])
if attachFaces is None:
    print("There is no selected face")
elif len(attachFaces) == 1:
    print("One face was selected")
    print(attachFaces)
else:
    print(str(len(attachFaces)) + " faces were selected")
    print(attachFaces)
