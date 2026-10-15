# Home.ExportGeometryBDF()

Home.ExportGeometryBDF()

Description​

Unknown Description

Syntax​

Home.ExportGeometryBDF(strFileName, crlParts=[], bBigID=False, bUseUnit=True, bVert=True, bEdge=True, bFace=True, bSolid=True)

Ribbon: Home » ExportGeometryBDF

Inputs​

strFileName​

A String specifying the file name.

This is a required input.

crlParts​

A List of Cursor specifying the part.

The default value is [].

bBigID​

A Boolean specifying the big ID.

The default value is False.

bUseUnit​

A Boolean specifying the use unit.

The default value is True.

bVert​

A Boolean specifying the vert.

The default value is True.

bEdge​

A Boolean specifying the edge.

The default value is True.

bFace​

A Boolean specifying the face.

The default value is True.

bSolid​

A Boolean specifying the solid.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Home.ExportGeometryBDF(strFileName, crlParts=[], bBigID=False, bUseUnit=True, bVert=True, bEdge=True, bFace=True, bSolid=True)
