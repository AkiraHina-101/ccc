# Home.Windows.TileVertical()

Home.Windows.TileVertical()

Description​

Display opening documents in a vertical side-by-side arrangement.

Syntax​

Home.Windows.TileVertical(...)

Macro: TileVertical, FrameLessVerticalMode1, FrameLessVerticalMode2, FrameLessVerticalMode3, FrameLessVerticalMode4, FrameLessVerticalMode5, FrameLessVerticalMode6, FrameLessVerticalMode7

Ribbon: Home » Windows » TileVertical

Inputs​

iMode​

An Integer specifying the vertical mode of arrangement.

0: Tile Vertical.

1: Mode 1.

2: Mode 2.

3: Mode 3.

4: Mode 4.

5: Mode 5.

6: Mode 6.

7: Mode 7.

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

# Tile vertical arrangement
Home.Windows.TileVertical(iMode=0)
