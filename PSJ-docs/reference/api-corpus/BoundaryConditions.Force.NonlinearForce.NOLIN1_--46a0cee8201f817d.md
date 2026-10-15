# BoundaryConditions.Force.NonlinearForce.NOLIN1()

BoundaryConditions.Force.NonlinearForce.NOLIN1()

Description​

Create Nonlinear Force of NOLIN1(Table).

Syntax​

BoundaryConditions.Force.NonlinearForce.NOLIN1(...)

Ribbon: BoundaryConditions » Force » NonlinearForce » NOLIN1

Inputs​

strName​

A String specifying the name.

The default value is "NonlinearForce1_1".

dForceScale​

A Double specifying the force scale.

The default value is 0.0.

dMomentScale​

A Double specifying the moment scale.

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

crCoord​

A Cursor specifying the coordinate.

The default value is None.

crForceTable​

A Cursor specifying the force table.

The default value is None.

crMomentTable​

A Cursor specifying the moment table.

The default value is None.

crlMaster​

A List of Cursor specifying the master.

The default value is [].

crlSlave​

A List of Cursor specifying the slave.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Force.NonlinearForce.NOLIN1(strName="NonlinearForce1_1", dForceScale=0.0, dMomentScale=0.0, iForcDir=0, iForceDepends=0, iMomentDir=0, iMomentDepends=0, crCoord=None, crForceTable=None, crMomentTable=None, crlMaster=[], crlSlave=[], crEdit=None)
