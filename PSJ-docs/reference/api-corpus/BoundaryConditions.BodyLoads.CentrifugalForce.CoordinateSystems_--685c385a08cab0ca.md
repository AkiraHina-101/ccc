# BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems()

BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems()

Description​

Create the centrifugal force load to refer to the coordinate system in the analysis model.

Syntax​

BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems(...)

Ribbon: BoundaryConditions » BodyLoads » CentrifugalForce » CoordinateSystems

Inputs​

crlTargets​

A List of Cursor specifying the list of the target items(Part/Bar) for creating the centrifugal force.

The default value is [].

strName​

A String specifying the name of the centrifugal force load condition to be created.

The default value is "CentrifugalForce1".

dVelocity​

A Double specifying the angular velocity value.

The default value is DFLT_DBL.

dAcceleration​

A Double specifying the angular acceleration value.

The default value is DFLT_DBL.

iAxisDirection​

An Integer specifying the rotation axis of coordinate system from X, Y or Z axis.

The default value is 0.

iVelocityUnit​

An Integer specifying the input unit of the angular velocity value.

The default value is 0.

iAccelerationUnit​

An Integer specifying the input unit of the angular acceleration value.

The default value is 0.

crCurCoord​

A Cursor specifying the coordinate system in which the centrifugal force is referenced.

The default value is None.

crEdit​

A Cursor specifying an existing centrifugal force load. If this parameter is used, the specified centrifugal force load will be modified. If it is left None, a new centrifugal force load will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(5, 8, 7)])

created_lbc = BoundaryConditions.BodyLoads.CentrifugalForce.CoordinateSystems(crlTargets=[Part(1)],
                                                                              dVelocity=10.0,
                                                                              dAcceleration=10.0,
                                                                              iAxisDirection=2,
                                                                              crCurCoord=Coord(1))

JPT.Debugger(created_lbc)
