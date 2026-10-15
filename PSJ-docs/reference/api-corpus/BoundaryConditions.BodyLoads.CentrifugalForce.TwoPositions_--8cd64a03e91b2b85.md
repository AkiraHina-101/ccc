# BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions()

BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions()

Description​

Create the centrifugal force load in the analysis model.

Syntax​

BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions(...)

Ribbon: BoundaryConditions » BodyLoads » CentrifugalForce » TwoPositions

Inputs​

crlTargets​

A List of Cursor specifying the list of the target items for creating the centrifugal force.

The default value is [].

strName​

A String specifying the name of the centrifugal force load condition to be created.

The default value is "CentrifugalForce1".

dBasePointX​

A Double specifying the X coordinate of the rotation axis reference point.

The default value is 0.0.

dBasePointY​

A Double specifying the Y coordinate of the rotation axis reference point.

The default value is 0.0.

dBasePointZ​

A Double specifying the Z coordinate of the rotation axis reference point.

The default value is 0.0.

dTipPointX​

A Double specifying the X coordinate of the rotation axis vertex.

The default value is 0.0.

dTipPointY​

A Double specifying the Y coordinate of the rotation axis vertex.

The default value is 0.0.

dTipPointZ​

A Double specifying the Z coordinate of the rotation axis vertex.

The default value is 0.0.

dVelocity​

A Double specifying the angular velocity value.

The default value is 0.0.

dAcceleration​

A Double specifying the angular acceleration value.

The default value is 0.0.

iVelocityUnit​

An Integer specifying the input unit of the angular velocity value.

The default value is 0.

iAccelerationUnit​

An Integer specifying the input unit of the angular acceleration value.

The default value is 0.

crEdit​

A Cursor specifying an existing centrifugal force load. If this parameter is used, the specified centrifugal force load will be modified. If it is left None, a new centrifugal force load will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions(crlTargets=[Part(1),
                                                                                     Node(5, 3)],
                                                                         dBasePointZ=0.01,
                                                                         dTipPointX=0.01,
                                                                         dTipPointY=0.01,
                                                                         dVelocity=10.0,
                                                                         dAcceleration=10.0)

JPT.Debugger(created_lbc)
