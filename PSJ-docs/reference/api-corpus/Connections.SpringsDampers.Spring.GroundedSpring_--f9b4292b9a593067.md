# Connections.SpringsDampers.Spring.GroundedSpring()

Connections.SpringsDampers.Spring.GroundedSpring()

Description​

Grounded Spring connection

Syntax​

Connections.SpringsDampers.Spring.GroundedSpring(iMethod=0, strName="SPRING", crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=DFLT_DBL, dStressCoef=DFLT_DBL, posTStiffness=[0,0,0], posRStiffness=[0,0,0], bUpdateDispCS=True, crEdit=None)

Ribbon: Connections » SpringsDampers » Spring » GroundedSpring

Inputs​

iMethod​

An Integer specifying the method.

The default value is 0.

strName​

A String specifying the name.

The default value is "SPRING".

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target.

The default value is [].

crCoordSys​

A Cursor specifying the coordinate system.

The default value is None.

iSpringType​

An Integer specifying the spring type.

The default value is 0.

iGround​

An Integer specifying the ground.

The default value is 0.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

iDirection​

An Integer specifying the direction.

The default value is 0.

iDistributeMode​

An Integer specifying the distribute mode.

The default value is 0.

iDof1​

An Integer specifying the dof1.

The default value is 0.

iDof2​

An Integer specifying the dof2.

The default value is 0.

dDampCoef​

A Double specifying the damp coefficient .

The default value is DFLT_DBL.

dStressCoef​

A Double specifying the stress coefficient .

The default value is DFLT_DBL.

posTStiffness​

A Position specifying the t stiffness.

The default value is [0,0,0].

posRStiffness​

A Position specifying the r stiffness.

The default value is [0,0,0].

bUpdateDispCS​

A Boolean specifying the update displacement coordinate system.

The default value is True.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.SpringsDampers.Spring.GroundedSpring(iMethod=0, strName="SPRING", crlMasterTargets=[], crlSlaveTargets=[], crCoordSys=None, iSpringType=0, iGround=0, dTolerance=0.0, iDirection=0, iDistributeMode=0, iDof1=0, iDof2=0, dDampCoef=DFLT_DBL, dStressCoef=DFLT_DBL, posTStiffness=[0,0,0], posRStiffness=[0,0,0], bUpdateDispCS=True, crEdit=None)
