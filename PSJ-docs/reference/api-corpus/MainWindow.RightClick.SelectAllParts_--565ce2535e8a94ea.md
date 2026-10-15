# MainWindow.RightClick.SelectAllParts()

MainWindow.RightClick.SelectAllParts()

Description​

Select all parts in the current document

Syntax​

MainWindow.RightClick.SelectAllParts(...)

Macro: ViewSelectAllParts

Ribbon: MainWindow » RightClick » SelectAllParts

Inputs​

This function does not require any input value.

Return Code​

A List of Cursor specifying the selected parts.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.Exec("View Fit To Model()")

# Select all parts
listParts = MainWindow.RightClick.SelectAllParts()
print(listParts)
