# BoundaryConditions.Force.FunctionLoadCylinder.Sine()

BoundaryConditions.Force.FunctionLoadCylinder.Sine()

Description​

Define the force load on selected entity based on the distribution of the sine function.

Syntax​

BoundaryConditions.Force.FunctionLoadCylinder.Sine(...)

Ribbon: BoundaryConditions » Force » FunctionLoadCylinder » Sine

Inputs​

strName​

A String specifying the name.

The default value is "ForceSine1".

dFTotalForce​

A Double specifying the total force.

The default value is 0.0.

dA​

A Double specifying the a.

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

bDistributeInAxis​

A Boolean specifying the distribute in axis.

The default value is False.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Force.FunctionLoadCylinder.Sine(strName="ForceSine1", dFTotalForce=0.0, dA=0.0, crCoord=None, iAngleBase=0, dAngleRange=0.0, iEnArrowDir=0, bDistributeInAxis=False, crlTargets=[], crEdit=None)
