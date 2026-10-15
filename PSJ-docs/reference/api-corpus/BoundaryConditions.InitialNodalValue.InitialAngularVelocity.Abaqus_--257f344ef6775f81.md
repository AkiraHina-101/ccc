# BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus()

BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus()

Description​

Create initial angular velocity for the Abaqus solver.

Syntax​

BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus(...)

Ribbon: BoundaryConditions » InitialNodalValue » InitialAngularVelocity » Abaqus

Inputs​

strName​

A String specifying the name.

The default value is "InitialAngularVelocityAbaqus1".

dVelocity​

A Double specifying the velocity.

The default value is DFLT_DBL.

strFirstCoord​

A String specifying the first coordinate.

The default value is "".

strSecondCoord​

A String specifying the second coordinate.

The default value is "".

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.InitialNodalValue.InitialAngularVelocity.Abaqus(strName="InitialAngularVelocityAbaqus1", dVelocity=DFLT_DBL, strFirstCoord="", strSecondCoord="", crlTargets=[], crEdit=None)
