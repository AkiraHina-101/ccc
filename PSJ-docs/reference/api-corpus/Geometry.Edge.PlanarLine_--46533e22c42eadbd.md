# Geometry.Edge.PlanarLine()

Geometry.Edge.PlanarLine()

Description​

Create edges at the intersection of the given faces and a planar face defining by 3 points or axis plane.

Syntax​

Geometry.Edge.PlanarLine(...)

Macro: ImprintPlannarLineS

Ribbon: Geometry » Edge » Planar Line

Inputs​

dllPoints​

A List of Position specifying the points which to define the planar face or the specific point that line passes through. Each point can be a Node, point on edge, or point on face. A valid value may one or three points on the list.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces on which the edges are imprinted.

This is a required input.

crLocalCoordinate​

A Cursor specifying the local coordinate.

The default value is None.

iAxisPlane​

An Integer specifying the reference axis plane. Possible values are 0, 1, 2 corresponding to XY, XZ, and YZ Plane. This option will only affect the functionality when there is a point in dllPoints only.

The default value is 0.

bBreakFace​

A Boolean specifying whether to break the given faces where possible.

The default value is True.

Return Code​

A List of Cursor specifying the new created edges.

Sample Code​

Geometry.Part.Cube()

edges = Geometry.Edge.PlanarLine(dllPoints=[[0.01, 0.005, 0.006]], 
                                 crlFaces=[Face(24, 26)], 
                                 iAxisPlane=1)

JPT.Debugger(edges)
