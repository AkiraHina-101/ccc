# MeshCleanup.Intersection()

MeshCleanup.Intersection()

Description​

Detect element intersection errors.

Syntax​

MeshCleanup.Intersection(...)

Macro: MC_Intersection

Ribbon: MeshCleanup » Intersection

Inputs​

crlParts​

A List of Cursor specifying target parts.

This is a required input.

dTolerance​

A Double specifying tolerance to detect intersection.

The default value is 0.001.

iDisplayTypeOption​

An Integer specifying which type of intersections displayed.

0: Body Intersection Only

1: All Intersection

2: Between Bodies Intersection

The default value is 0.

iElementLayers​

An Integer specifying the number of layers surrounding error elements id displayed.

The default value is 1.

bErrorText​

A Boolean specifying whether or not output information about element intersections as text data to the output window and the Temp folder.

The default value is False.

Return Code​

MESH_QUALITY_FREE_EDGE​

bSuccess​

A Bool type value indicating whether the function succeeded or not.

iIntersectElements​

An Integer type value indicating the number of intersection elements.

crlElemEdges​

A List of Cursor type value indicating intersection elements.

Sample Code​

#Prepare Model
Geometry.Part.Cube(strName="Cube_1", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Edge.Angle(
    [CursorPair(Node(452), Node(460)), 
    CursorPair(Node(92), Node(200)), 
    CursorPair(Node(28), Node(392)), 
    CursorPair(Node(12), Node(108))])

Geometry.Face.Edges(crlEdges=[Edge(60, 58)])

#Check body intersection
res=MeshCleanup.Intersection(crlParts=[Part(1,2)], dTolerance=1e-06, iDisplayTypeOption=0)
JPT.Debugger(res)

#Check intersection between bodies
res=MeshCleanup.Intersection(crlParts=[Part(1,2)], dTolerance=1e-06, iDisplayTypeOption=2)
JPT.Debugger(res)
