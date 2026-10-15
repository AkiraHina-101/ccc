# BoundaryConditions.Force.FunctionLoadCylinder.Vector()

BoundaryConditions.Force.FunctionLoadCylinder.Vector()

Description​

Define the force load on selected entity based on the distribution of the vector function.

Syntax​

BoundaryConditions.Force.FunctionLoadCylinder.Vector(...)

Ribbon: BoundaryConditions » Force » FunctionLoadCylinder » Vector

Inputs​

strName​

A String specifying the name.

The default value is "ForceVector1".

dFTotalForce​

A Double specifying the total force.

The default value is DFLT_DBL.

dA​

A Double specifying the a.

The default value is DFLT_DBL.

dX​

A Double specifying the x.

The default value is DFLT_DBL.

dY​

A Double specifying the y.

The default value is DFLT_DBL.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

iEnDirection​

An Integer specifying the en direction.

The default value is 0.

dAngleRange​

A Double specifying the angle range.

The default value is 0.0.

iArrowDir​

An Integer specifying the arrow direction.

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

BoundaryConditions.Force.FunctionLoadCylinder.Vector(strName="ForceVector1", dFTotalForce=DFLT_DBL, dA=DFLT_DBL, dX=DFLT_DBL, dY=DFLT_DBL, crCoord=None, iEnDirection=0, dAngleRange=0.0, iArrowDir=0, bDistributeInAxis=False, crlTargets=[], crEdit=None)
