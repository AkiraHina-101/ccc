# BoundaryConditions.InitialNodalValue.Velocity()

BoundaryConditions.InitialNodalValue.Velocity()

Description​

Create initial velocity.

Syntax​

BoundaryConditions.InitialNodalValue.Velocity(...)

Ribbon: BoundaryConditions » InitialNodalValue » Velocity

Inputs​

strName​

A String specifying the name.

The default value is "InitialRotationAngle1".

stData​

A ST_DATA specifying the data.

The default value is LBC_DYNAMIC_INITIAL_CONDITION_DATA().

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.InitialNodalValue.Velocity(strName="InitialRotationAngle1", stData=LBC_DYNAMIC_INITIAL_CONDITION_DATA(), crlTargets=[], crEdit=None)
