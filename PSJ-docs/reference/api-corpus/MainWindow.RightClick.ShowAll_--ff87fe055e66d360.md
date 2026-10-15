# MainWindow.RightClick.ShowAll()

MainWindow.RightClick.ShowAll()

Description​

Show all hidden entities.

Syntax​

MainWindow.RightClick.ShowAll(...)

Macro: ViewShowAll

Ribbon: MainWindow » RightClick » ShowAll

Inputs​

This function does not require any input value.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.ViewFitToModel()

# Hide some parts
JPT.Exec("Show_Entity([3:2, 3:3], 0)")
# Show all parts again
MainWindow.RightClick.ShowAll()
