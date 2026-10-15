# Connections.SpringsDampers.Damper.AnyEntities11DoFS()

Connections.SpringsDampers.Damper.AnyEntities11DoFS()

Description​

Create Damper Connection

Syntax​

Connections.SpringsDampers.Damper.AnyEntities11DoFS(iMethod, strName, crlMasterTargets, crlSlaveTargets, crCoordSys=None, iGround=0, dTolerance=0.0, vecTDamper=[0, 0, 0], vecRDamper=[0, 0, 0], crEdit=None, bUpdateDispCS=True)

Ribbon: Connections » SpringsDampers » Damper » AnyEntities11DoFS

Inputs​

iMethod​

An Integer specifying the method.

This is a required input.

strName​

A String specifying the name.

This is a required input.

crlMasterTargets​

A List of Cursor specifying the master target.

This is a required input.

crlSlaveTargets​

A List of Cursor specifying the slave target.

This is a required input.

crCoordSys​

A Cursor specifying the coordinate system.

The default value is None.

iGround​

An Integer specifying the ground.

The default value is 0.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

vecTDamper​

A Vector specifying the t damper.

The default value is [0, 0, 0].

vecRDamper​

A Vector specifying the r damper.

The default value is [0, 0, 0].

crEdit​

A Cursor specifying the edit.

The default value is None.

bUpdateDispCS​

A Boolean specifying the update displacement coordinate system.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.SpringsDampers.Damper.AnyEntities11DoFS(iMethod, strName, crlMasterTargets, crlSlaveTargets, crCoordSys=None, iGround=0, dTolerance=0.0, vecTDamper=[0, 0, 0], vecRDamper=[0, 0, 0], crEdit=None, bUpdateDispCS=True)
