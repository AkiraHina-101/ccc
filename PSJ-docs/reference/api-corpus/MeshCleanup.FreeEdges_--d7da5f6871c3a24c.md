# MeshCleanup.FreeEdges()

MeshCleanup.FreeEdges()

Description​

Check free edges and non-manifolds.

Syntax​

MeshCleanup.FreeEdges(...)

Macro: MC_FreeEdge

Ribbon: MeshCleanup » FreeEdges

Inputs​

crlParts​

A List of Cursor specifying target parts to check free edges / non-manifolds.

This is a required input.

iMeshColor​

An Integer specifying mesh color in Free Edge mode.

0: Original

1: Gray

The default value is 0.

bDisplayAll​

A Boolean specifying whether or not display all the meshes.

The default value is False.

iElemLayers​

An Integer specifying number of display mesh layers around free edges / non-manifolds.

The default value is 1.

bDisplayFreeEdges​

A Boolean specifying whether or not check free edges.

The default value is True.

bFreeEdgeByPart​

A Boolean specifying whether or not check free edges by part.

The default value is False.

bDisplayNonManifold​

A Boolean specifying whether or not check non-manifolds.

The default value is True.

iNonManifoldThreshold​

An Integer specifying the minimum number of connected components for the non-manifold.

The default value is 3.

bHideBoundaryEdge​

A Boolean specifying whether or not ignores boundary edges as free edges.

The default value is False.

bErrorText​

A Boolean specifying whether or not to export information of free edges / non-manifolds to a text file.

The default value is False.

Return Code​

A Boolean specifying the function successfully executed or not.

Sample Code​

#Create a model.
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
mating_face=Assemble.FindMatingFaceEx(
    crlTaBodies=[Part(1, 2)], 
    dMatingTol=0.000222222)
Assemble.AssembleFaceEx(
    ilPairFaceToMakeShareFace=mating_face, 
    dTolerance=0.000222222, 
    iTypeConnectPos=0)
JPT.Exec('DeleteFace([49], 1)')
Geometry.Part.Cube(dlOrigin=[0.01, 0.015, 0.0], strName="Cube_3", iPartColor=7697908)
Geometry.Edge.Angle([
    CursorPair(Node(1069), Node(1461)), 
    CursorPair(Node(1069), Node(1184)), 
    CursorPair(Node(1005), Node(1376)), 
    CursorPair(Node(989), Node(1085))])
Geometry.Face.Edges(crlEdges=[Edge(98, 97, 96, 95)])
Geometry.Part.Cube(dlOrigin=[0.0, 0.015, 0.0], strName="Cube_4", iPartColor=7463537)
JPT.Exec('DeleteFace([133], 1)')
JPT.Exec('DeleteFace([129], 1)')
JPT.Exec('DeleteFace([132], 1)')
JPT.Exec('DeleteFace([128], 1)')
JPT.Exec('DeleteFace([131], 1)')

#Check free edges and non-manifolds.
ret=MeshCleanup.FreeEdges(crlParts=[Part(1, 2, 3, 4)], bFreeEdgeByPart=True, bErrorText=True)
print(f"{ret.iFreeEdges}/72")
print(f"{ret.iNonManifoldEdges}/36")
