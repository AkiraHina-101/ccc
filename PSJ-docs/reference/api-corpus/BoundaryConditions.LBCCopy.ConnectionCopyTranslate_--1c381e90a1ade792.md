# BoundaryConditions.LBCCopy.ConnectionCopyTranslate()

BoundaryConditions.LBCCopy.ConnectionCopyTranslate()

Description​

Copy boundary conditions by using translation method.

Syntax​

BoundaryConditions.LBCCopy.ConnectionCopyTranslate(...)

Ribbon: BoundaryConditions » LBCCopy » ConnectionCopyTranslate

Inputs​

iMethod​

An Integer specifying the connection copy method:
0: Translation method. The copy destination is searched by translation in the X, Y, and Z directions.

1: Rotation method. The copy destination is searched by the rotational movement of the specified axis.

2: Mirror method. Search the copy destination by plane and offset amount. To define a plane, select 3 nodes or 2D elements.

The default value is 0.

iMatchMethod​

An Integer specifying the match method:
0: Node method. This matching method matches the exact nodes of the target to get matching results. It is useful when the target features are different.

1: Feature method. This matching method is very fast, especially for large models, and requires face-to-face, vertex to vertex like feature matching.

The default value is 0.

posVecTrans​

A List specifying the translational vector.

The default value is [0,0,0].

dMagnitude​

A Double specifying the magnitude of the move distance of the copy destination.

The default value is 1.0.

dTrandataDoffset​

A Double specifying the trandata offset.

The default value is 0.0.

dTol​

A Double specifying the tolerance value to be used for determination of conformity.

Unit of length.

The default value is 1.0.

crCoord​

A Cursor specifying the coordinate system.

The default value is None.

crlTargets​

A List of Cursor specifying the list of targets.

The default value is [].

Return Code​

A Cursor specifying the created LBCs.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_3", 
                   iPartColor=13259210)

BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])

created_lbc = BoundaryConditions.LBCCopy.LBCCopyTranslate(posVecTrans=[-0.001, 0, 0], 
                                                          dMagnitude=0.03, 
                                                          dTol=0.1, 
                                                          crlTargets=[LbcConstraint(1)])

JPT.Debugger(created_lbc)
