# Geometry.AdvancedShellAssembly()

Geometry.AdvancedShellAssembly()

Description​

This method connects the given faces between assembly models of multiple shell parts.

Syntax​

Geometry.AdvancedShellAssembly(crlParts=[], crlFaces=[], iMeshType=0, bSelfIntersection=False,
    iMethod=3, dGapTol=2.1)

Ribbon: Geometry » Advanced Shell Assembly

Inputs​

crlParts​

A List of Cursor specifying the parts to assemble. Either crlParts or crlFace must be specified.

The default value is [].

crlFaces​

A List of Cursor specifying the faces to assemble. Either crlParts or crlFace must be specified.

The default value is [].

iMeshType​

An Integer specifying the surrounding element type of the connecting region.

If iMeshType=0, the mesh on the face is a triangular primary element.

If iMeshType=1, the mesh on the face is a quadrilateral primary element. The mesh around the assembly edge will be re-meshed into a square mesh.

The default value is 0.

bSelfIntersection​

A Boolean specifying whether or not the self-intersecting parts should be assembled.

The default value is False.

iMethod​

An Integer specifying how to connect between faces.

If iMethod=0, within the interval threshold, the free edge detects a portion not in contact with the face and stretches the free edge to the face to imprint and connect.

If iMethod=1, connect the edges that exist within the interval threshold.

If iMethod=2, detect face intersections and imprint the edges.

If iMethod=3, the above three patterns are judged automatically. The assembly edges are imprinted and connected appropriately.

The default value is 3.

dGapTol​

A Double specifying the distance to determine that the face and the edge, and the edge and the edge are connected.

The default value is 2.1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=8124407)

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=14441436)

Geometry.AdvancedShellAssembly(crlParts=[Part(2, 1)])
