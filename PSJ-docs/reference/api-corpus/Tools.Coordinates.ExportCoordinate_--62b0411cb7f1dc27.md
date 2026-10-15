# Tools.Coordinates.ExportCoordinate()

Tools.Coordinates.ExportCoordinate()

Description​

Export local coordinates as Nastran bdf format.

Syntax​

Tools.Coordinates.ExportCoordinate(...)

Macro:

Ribbon: Tools » Coordinates » Export Coordinate

Inputs​

strlPath​

A List of String specifying path to import file.

The default value is "".

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
