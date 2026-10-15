# MainWindow.RightClick.InverseHide()

MainWindow.RightClick.InverseHide()

Description​

Invert hide targets by context menu

Syntax​

MainWindow.RightClick.InverseHide(...)

Macro: ViewInverseHide

Ribbon: MainWindow » RightClick » InverseHide

Inputs​

crlTargets​

A List of Cursor specifying the targets to be inverted hide. The target can be Part or Face.

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
target = MainWindow.RightClick.InverseHide(crlTargets=[Part(1)])
JPT.Debugger(target)
