# Home.Windows.TileHorizontal()

Home.Windows.TileHorizontal()

Description​

Display opening documents in a horizontal arrangement.

Syntax​

Home.Windows.TileHorizontal(...)

Macro: TileHorizontal, FrameLessHorizontalMode1, FrameLessHorizontalMode2, FrameLessHorizontalMode3, FrameLessHorizontalMode4, FrameLessHorizontalMode5, FrameLessHorizontalMode6, FrameLessHorizontalMode7

Ribbon: Home » Windows » TileHorizontal

Inputs​

iMode​

An Integer specifying the horizontal mode of arrangement.

0: Tile Horizontal.

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

# Tile horizontal arrangement
Home.Windows.TileHorizontal(iMode=0)
