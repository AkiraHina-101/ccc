# Geometry.FindFeature.Face()

Geometry.FindFeature.Face()

Description​

Find and select the specific faces according to their characteristic.

Syntax​

Geometry.FindFeature.Face(...)

Ribbon: Geometry » FindFeature » Faces

Inputs​

crlParts​

A List of Cursor specifying the parts to find the specific faces.

This is a required input.

iFaceType​

An Integer specifying the specific type of Faces.

If iFaceType=0, find and select the faces that are bounded by four corners.

If iFaceType=1, find and select the planar faces.

If iFaceType=2, find and select the faces of the cylindrical surface.

If iFaceType=3, find and select the faces of the semi-cylindrical surface.

If iFaceType=4, find and select the disk-shaped faces.

If iFaceType=5, find and select the faces of map mesh.

If iFaceType=6, find and select the circular chamfer faces.

If iFaceType=7, find and select the fillet faces.

The default value is 0.

bCylinder​

A Boolean specifying whether to find cylinder face of map mesh. This argument is to be used if iOption=5.

The default value is True.

bDisc​

A Boolean specifying whether to find disk-shaped face of map mesh. This argument is to be used if iOption=5.

The default value is False.

bFourCorners​

A Boolean specifying whether to find the faces that are bounded by four corners of map mesh. This argument is to be used if iFaceType=5.

The default value is True.

dMinThickness​

A Double specifying the minimum thickness of the circular chamfer surface. This argument is to be used if iFaceType=6.

The default value is 0.1.

dMaxThickness​

A Double specifying the maximum thickness of the circular chamfer surface. This argument is to be used if iFaceType=6.

The default value is 2.0.

Return Code​

A List cursor of faces if success, or None if fail.

Sample Code​

cube = Geometry.Part.Cube()
faces = Geometry.FindFeature.Face(crlParts=[cube])
JPT.Debugger(faces)
