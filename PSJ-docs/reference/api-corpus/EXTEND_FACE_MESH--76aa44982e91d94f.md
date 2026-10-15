# EXTEND_FACE_MESH

EXTEND_FACE_MESH

Description​

A data type used to control the mesh settings of extended face.

Attributes​

iLengthToFace​

An Integer specifying the destination method.

0: Length

1: To Face

The default value is 0.

dLengthToFace​

A Double specifying the length value when iLengthToFace=0.

The default value is 0.01.

bUseDivision​

A Boolean specifying whether to use the mesh division or mesh size method.

True: Num of Divisions

False: Mesh Size

The default value is True.

iNumOfDivisions​

An Integer specifying the number of divisions.

The default value is 3.

dMeshSize​

A Double specifying the mesh size.

The default value is 0.001.

dBiasFactor​

A Double specifying the bias factor.

The default value is 1.

iElemType​

An Integer specifying the element type.

0: Tri3

1: Quad4

The default value is 0.

dLength​

A Double specifying the length value when iMetric=4, iMethod=4.

The default value is 0.01.

dMeshSizeAxis​

A Double specifying the mesh size (Axis) value when iMetric=4. iMethod=4.

The default value is 0.01.

dArcRadius​

A Double specifying the arc radius value when iMetric=4, iMethod=0.

The default value is 0.01.

dAngleOffset​

A Double specifying the angle offset value when iMetric=4, iMethod=2.

The default value is 45.

dArcLength​

A Double specifying the arc length value when iMetric=4,iMethod=3.

The default value is 7.85E-3.

dArcNodesNum​

A Double specifying the arc node number when iMetric=4.

The default value is 5.0.
