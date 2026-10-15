# EXTEND_FACE_DIRECTION

EXTEND_FACE_DIRECTION

Description​

A data type used to control the direction settings for extended face.

Attributes​

iMetric​

An Integer specifying the method to create the face.

0: Coordinate

1: 2 Nodes

2: Element Edge

3: Offset

4: Cylinder

The default value is 0.

iCoordinateSystem​

An Integer specifying the referent coordinate system when iMetric=0.

The default value is 0 (Global).

iDirection​

An Integer specifying direction to extend the face when iMetric=0.

0: By Components

1: By Angles

The default value is 0.

dComponentX​

A Double specifying X direction when iDirection=0.

The default value is 1.

dComponentY​

A Double specifying Y direction when iDirection=0.

The default value is 1.

dComponentZ​

A Double specifying Z direction when iDirection=0.

The default value is 1.

dAngleTheta​

A Double specifying theta value when iDirection=1.

The default value is 45.

dAnglePhi​

A Double specifying phi value when iDirection=1.

The default value is 45.

bBothDirections​

A Boolean specifying whether to extend the face in both direction.

The default value is False.

bReverseDirection​

A Boolean specifying whether to create a face in the opposite direction.

The default value is False.

iMethod​

An Integer specifying method to create the face when iMetric=4.

0: To Axis

1: To Face

2: Arc Angle

3: Arc Length

4: Sweep

The default value is 0.

iAxisPlane​

An Integer specifying axis plane when iMethod=0.

0: XY

1: YZ

2: ZX

The default value is 0.

dZXY​

A Double specifying parameter of Z / X / Y

The default value is 0.001.
