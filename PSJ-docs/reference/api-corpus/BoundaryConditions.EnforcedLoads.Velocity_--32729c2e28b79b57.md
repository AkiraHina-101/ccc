# BoundaryConditions.EnforcedLoads.Velocity()

BoundaryConditions.EnforcedLoads.Velocity()

Description​

Create enforced velocity to face, edge or node. User inputs enforced velocity parameters, and it will return enforced velocity to the specified location.

Syntax​

BoundaryConditions.EnforcedLoads.Velocity(...)

Ribbon: Boundary Conditions » Enforced Loads » Velocity

Inputs​

strName​

A String specifying the enforced velocity load name.

The default value is "EnforcedVelocity1".

enforceVelocity​

An ENFORCED_VELOCITY_LBC specifying the enforced velocity parameters.

This is a required input.

crlTargets​

A List of Cursor specifying the list of targets to apply enforced velocity. Target can be face, edge or node.

This is a required input.

crEdit​

A Cursor specifying an existing enforced velocity.
If this parameter is used, the specified enforced velocity will be modified.

If it is left None, a new enforced velocity will be created.

The default value is None.

bADVCStatic​

A Boolean specifying whether to create 2 ADVC Static processes for bolt fix length or not.

The default value is False.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.EnforcedLoads.Velocity(enforceVelocity=ENFORCED_VELOCITY_LBC(iDwDof=1,
                                                                                              dVelocityTX=0.001), 
                                                        crlTargets=[Face(24)])

JPT.Debugger(created_bcs)
