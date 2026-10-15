# Geometry.Edge.OffsetLine()

Geometry.Edge.OffsetLine()

Description​

Create new edges by offsetting specified edges.

Syntax​

Geometry.Edge.OffsetLine(...)

Macro: ImprintOffsetLineS

Ribbon: Geometry » Edge » Offset Line

Inputs​

crlFaces​

A List of Cursor specifying the target faces on which the edges are imprinted.

This is a required input.

crlEdges​

A List of Cursor specifying the edges to be offset.

This is a required input.

bBreakFace​

A Boolean specifying whether to break the given faces where possible.

The default value is True.

dOffsetDistance​

A Double specifying the offset distance.

The default value is 0.0.

iLayerNumber​

An Integer specifying the number of layers to be offset.

The default value is 1.

bMerge​

A Boolean specifying whether or not to merge the offset edges when the angle between them is bigger than 150 degrees.

The default value is True.

bExtend​

A Boolean specifying whether to extend the offset edges to the nearest boundary edges.

The default value is True.

iOffsetMethod​

An Integer specifying how to create offset edges.

If iOffsetMethod=0, create multiple offset layers using the offset distance and the number of layers.

If iOffsetMethod=1, create single offset layer using the layer offset distance.

The default value is 0.

dOffsetDistance​

A List of Double specifying the layer offset distance.

The default value is [].

iImprintMethod​

An Integer specifying imprint method.

If iImprintMethod=0, offset edges will be imprinted onto the face side that has the longest edges.

If iImprintMethod=1, offset edges will be imprinted onto the face side that has the shortest edges.

If iImprintMethod=2, offset edges will be imprinted onto both face sides.

The default value is 2.

Return Code​

A List of Cursor specifying the new created edges.

Sample Code​

Geometry.Part.Cube(iPartColor=6484066)

offset_lines = Geometry.Edge.OffsetLine(crlFaces=[Face(22)], 
                                        crlEdges=[Edge(19)], 
                                        dOffsetDistance=0.001, 
                                        iLayerNumber=6)

JPT.Debugger(offset_lines)
