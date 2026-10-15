# Connections.RigidWall()

Connections.RigidWall()

Description​

Define a rigid wall contact setting to simulate impact analyses with planar rigid walls.

Syntax​

Connections.RigidWall(...)

Ribbon: Connections » RigidWall

Inputs​

strName​

A String specifying the rigid wall name.

The default value is "RigidWall1".

iObject​

An Integer specifying the rigid object type.

0: Planar rigid object.

The default value is 0.

iType​

An Integer specifying the rigid wall type.

0: Infinite body.

1: Finite body.

The default value is 0.

iMotion​

An Integer specifying the behavior.

0: Static - Stationary.

1: Moving - Movable.

The default value is 0.

iFriction​

An Integer specifying the condition of friction types. The friction type of rigid wall contact definition is one of the following.

0: Frictionless - No friction.

1: No Sliding - No slip.

2: Coulomb Friction - Coulomb friction.

3: Weld with Frictionless - Frictionless welding.

4: Weld with No Sliding - Non-slip welding.

The default value is 0.

iOrthoFriction​

An Integer specifying whether or not using rigid orthotropic frictional coefficient.

0: No

1: Yes

The default value is 0.

iForces​

An Integer specifying whether or not considering the reaction force.

0: No

1: Yes

The default value is 0.

dFinite1​

A Double specifying length of l(x) edge when Finite body is used.

The default value is DFLT_DBL.

dFinite2​

A Double specifying length of m(y) edge when Finite body is used.

The default value is DFLT_DBL.

dMotionMass​

A Double specifying the motion mass when Moving behavior is used.

The default value is DFLT_DBL.

dMotionInitVelocity​

A Double specifying the motion initial velocity Moving behavior is used.

The default value is DFLT_DBL.

dFricCoulombCoeff​

A Double specifying the friction coulomb coefficient when Coulomb Friction is used.

The default value is DFLT_DBL.

dFricWeldVelocity​

A Double specifying the critical normal velocity for weld when Frictionless welding is used.

The default value is DFLT_DBL.

iForcesCirclesNum​

An Integer specifying the number of forces cycles when reaction force is used.

The default value is 0.

dOrthoStaticCoeff1​

A Double specifying the ortho static friction coefficient a when rigid Ortho is used.

The default value is DFLT_DBL.

dOrthoStaticCoeff2​

A Double specifying the ortho static friction coefficient b when rigid Ortho is used.

The default value is DFLT_DBL.

dOrthoDynamicCoeff1​

A Double specifying the ortho dynamic friction coefficient a when rigid Ortho is used.

The default value is DFLT_DBL.

dOrthoDynamicCoeff2​

A Double specifying the ortho dynamic friction coefficient b when rigid Ortho is used.

The default value is DFLT_DBL.

dOrthoDecayConst1​

A Double specifying the decay constant a-direction a.

The default value is DFLT_DBL.

dOrthoDecayConst2​

A Double specifying the decay constant a-direction b.

The default value is DFLT_DBL.

dOrthoFricVector1​

A Double specifying the ortho Friction Vector - x value.

The default value is DFLT_DBL.

dOrthoFricVector2​

A Double specifying the ortho Friction Vector - y value.

The default value is DFLT_DBL.

dOrthoFricVector3​

A Double specifying the ortho Friction Vector - z value.

The default value is DFLT_DBL.

bAllNodeSlave​

A Boolean specifying whether or not considering all nodes to be subordinate points.

The default value is False.

crCoord​

A Cursor specifying the local coordinate. If the crCoord does not specify any local coordinate, function will execute with global coordinate.

The default value is None.

crAreaFaceSet​

A Cursor specifying the Selected Force Area Face when reaction force is used.

The default value is None.

crVisualNodeSet​

A Cursor specifying the Selected Visualization Node Set when reaction force is used.

The default value is None.

crlTargets​

A List of Cursor specifying the list of targets will be set up as rigid wall.

This is the required input.

crEdit​

A Cursor specifying an existing rigid wall contact setting. If this parameter is used, the specified rigid wall contact setting will be modified. When the default value is used, a new rigid wall contact setting will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified rigid wall contact connection.

Sample Code​

Geometry.Part.Cube(iPartColor=16053365)
created_wall = Connections.RigidWall(crlTargets=[Face(24)])
JPT.Debugger(created_wall)
