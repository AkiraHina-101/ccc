# Tools.Coordinates.ImportCoordinate()

Tools.Coordinates.ImportCoordinate()

Description​

Import local coordinates as Nastran BDF or ADVC ADX format.

Syntax​

Tools.Coordinates.ImportCoordinate(...)

Macro:

Ribbon: Tools » Coordinates » Import Coordinate

Inputs​

strlPath​

A List of String specifying path to export file.

The default value is "".

crlCS​

A List of Cursor specifying local coordinates.

The default value is None.

Return Code​

A Boolean specifying succeeded or not.

Sample Code​

#Prepare model
Geometry.Part.Cube(iPartColor=6409934)

#Prepare coordinates
lcs1=Tools.Coordinates.ThreeNode(
    strName="CRect_1", 
    crlNodes=[Node(7, 6, 445)])

lcs2=Tools.Coordinates.ThreeNode(
    strName="CRect_2", 
    crlNodes=[Node(310, 317, 336)])

#Export coordinates

import os 
temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

Tools.Coordinates.ExportCoordinate(
    strlPath=os.path.join(temp_path,'exp-lcs.bdf'), 
    crlCS=[lcs1,lcs2])

#Delete the created coordinates

JPT.Exec(f"DeleteItem(0, [{lcs1},{lcs2}], [], [], 1)")

#Recreate coordinates by import coordinates exported before

Tools.Coordinates.ImportCoordinate(
    strlPath=os.path.join(temp_path,'exp-lcs.bdf'))
