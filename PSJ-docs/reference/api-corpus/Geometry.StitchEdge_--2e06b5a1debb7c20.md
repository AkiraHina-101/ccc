# Geometry.StitchEdge()

Geometry.StitchEdge()

Description​

This method stitches any gap between free edges that are slightly apart.

Syntax​

Geometry.StitchEdge(crlMaster, crlSlave, dTolerance=0.3, bKeepSlave=True)

Macro: StitchEdge

Ribbon: Geometry » Stitch Edge

Inputs​

crlMaster​

A List of Cursor specifying master edges will be retained after operation.

This is a required input.

crlSlave​

A List of Cursor specifying slave edges to be stitched.

This is a required input.

dTolerance​

A Double specifying the stitch tolerance. The free edges are at a distance less than or equal to the specified value will be stitched.

The default value is 0.3.

bKeepSlave​

A Boolean specifying whether to keep slave nodes after the stitch operation.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Part.Cube(dlOrigin=[0.01, 0.01, 0.0], ilNodeCnt=[10, 10, 11], strName="Cube_2")

Geometry.StitchEdge(crlMaster=[Edge(15)], crlSlave=[Edge(39))
