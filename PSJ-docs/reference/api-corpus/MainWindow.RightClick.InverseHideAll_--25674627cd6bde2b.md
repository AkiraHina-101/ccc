# MainWindow.RightClick.InverseHideAll()

MainWindow.RightClick.InverseHideAll()

Description​

Hide all targets other than the specified face.(Display only the specified faces)

Syntax​

MainWindow.RightClick.InverseHideAll(...)

Macro: ViewInverseHideAll

Ribbon: MainWindow » RightClick » InverseHideAll

Inputs​

crlTargets​

A List of Cursor specifying the target faces to display only.

The default value is [].

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# Invert hide Part(1)
target = MainWindow.RightClick.InverseHideAll(crlTargets=[Face(26)])
JPT.Debugger(target)
