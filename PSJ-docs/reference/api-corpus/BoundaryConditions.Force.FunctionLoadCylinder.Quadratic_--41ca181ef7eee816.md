# BoundaryConditions.Force.FunctionLoadCylinder.Quadratic()

BoundaryConditions.Force.FunctionLoadCylinder.Quadratic()

Description​

Create Force (Quadratic) y = a*x^2 + b.

Syntax​

BoundaryConditions.Force.FunctionLoadCylinder.Quadratic(...)

Ribbon: BoundaryConditions » Force » FunctionLoadCylinder » Quadratic

Inputs​

strName​

A String specifying the name.

The default value is "ForceQuadratic1".

dFTotalForce​

A Double specifying the total force.

The default value is 0.0.

dA​

A Double specifying the a.

The default value is 0.0.

dB​

A Double specifying the .

The default value is 0.0.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

iAngleBase​

An Integer specifying the angle base.

The default value is 0.

dAngleRange​

A Double specifying the angle range.

The default value is 0.0.

iEnArrowDir​

An Integer specifying the en arrow direction.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Force.FunctionLoadCylinder.Quadratic(strName="ForceQuadratic1", dFTotalForce=0.0, dA=0.0, dB=0.0, crCoord=None, iAngleBase=0, dAngleRange=0.0, iEnArrowDir=0, crlTargets=[], crEdit=None)
