# MainWindow.RightClick.SetPartAppearance()

MainWindow.RightClick.SetPartAppearance()

Description​

Set the appearance of the selected parts.

Syntax​

MainWindow.RightClick.SetPartAppearance(...)

Macro: SetPartAppearance

Ribbon: MainWindow » RightClick » SetPartAppearance

Inputs​

crlParts​

A List of Cursor specifying

This is a required input.

strType​

A String specifying appearance target.

"Surface"

"Mesh"

"Edge"

"Node"

This is a required input.

bShow​

A Boolean specifying Show or Hide.

The default value is True (Show).

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

# Prepare model
JPT.Exec('ViewShowMesh(1)')
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)

MainWindow.RightClick.SetPartAppearance(crlParts=[Part(1)], strType="Surface", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(2)], strType="Edge", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(3)], strType="Mesh", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Node", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Surface", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Mesh", bShow=False)

JPT.ViewFitToModel()
