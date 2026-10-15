# MainWindow.RightClick.ShowHideEntity()

MainWindow.RightClick.ShowHideEntity()

Description​

Show/hide the specified targets.

Syntax​

MainWindow.RightClick.ShowHideEntity(...)

Macro:

Ribbon: MainWindow » RightClick » ShowHideEntity

Inputs​

crlTargets​

A List of Cursor specifying the target to be shown/hidden.

The default value is [].

bShow​

A Boolean specifying whether to show or hide the selected target.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare the model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)

# Hide faces
target = MainWindow.RightClick.ShowHideEntity(crlTargets=[Face(26, 52, 78)], bShow=False)
JPT.Debugger(target)

# Show Face(26) only
target = MainWindow.RightClick.ShowHideEntity(crlTargets=[Face(26)], bShow=True)
JPT.Debugger(target)
