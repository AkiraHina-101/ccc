# BoundaryConditions.Force.NonlinearForce.NOLIN3()

BoundaryConditions.Force.NonlinearForce.NOLIN3()

Description​

Create nonlinear force NOLIN3.

Syntax​

BoundaryConditions.Force.NonlinearForce.NOLIN3(...)

Ribbon: BoundaryConditions » Force » NonlinearForce » NOLIN3

Inputs​

strName​

A String specifying the name.

This is a required input.

dForceScale​

A Double specifying the force scale.

The default value is 0.0.

dMomentScale​

A Double specifying the moment scale.

The default value is 0.0.

dForcePowerA​

A Double specifying the force power a.

The default value is 0.0.

dMomentPowerA​

A Double specifying the moment power a.

The default value is 0.0.

iForcDir​

An Integer specifying the forc direction.

The default value is 0.

iForceDepends​

An Integer specifying the force depends.

The default value is 0.

iMomentDir​

An Integer specifying the moment direction.

The default value is 0.

iMomentDepends​

An Integer specifying the moment depends.

The default value is 0.

crCurCoord​

A Cursor specifying the cur coordinate.

The default value is None.

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Force.NonlinearForce.NOLIN3(strName, dForceScale=0.0, dMomentScale=0.0, dForcePowerA=0.0, dMomentPowerA=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCurCoord=None, crlMasterTargets=[], crlSlaveTargets=[], crEdit=None)
