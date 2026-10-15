# Home.Windows.TileBox()

Home.Windows.TileBox()

Description​

Display opening documents in vertical and horizontal arrangement like a box.

Syntax​

Home.Windows.TileBox(...)

Macro: FrameLessBoxMode1, FrameLessBoxMode2

Ribbon: Home » Windows » TileBox

Inputs​

iMode​

An Integer specifying the mode of arrangement.

1: Mode 1.

2: Mode 2.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare 2 JPT documents
Geometry.Part.Cube()
JPT.ViewFitToModel()
JPT.CreateNewDocument()
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# Tile box arrangement
Home.Windows.TileBox(iMode=1)
