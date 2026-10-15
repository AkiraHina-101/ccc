# Connections.RigidElements.RBE2General()

Connections.RigidElements.RBE2General()

Description​

Unknown Description

Syntax​

Connections.RigidElements.RBE2General(iMethod, crlMasterTargets, crlSlaveTargets, iEType=2, strName="RBE2_1", crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iDuplicateMode=-1)

Macro: Rbe2

Ribbon: Connections » RigidElements » RBE2General

Inputs​

iMethod​

An Integer specifying the method.

This is a required input.

crlMasterTargets​

A List of Cursor specifying the master target.

This is a required input.

crlSlaveTargets​

A List of Cursor specifying the slave target.

This is a required input.

iEType​

An Integer specifying the e type.

The default value is 2.

strName​

A String specifying the name.

The default value is "RBE2_1".

crCoordSys​

A Cursor specifying the coordinate system.

The default value is None.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

iUlDOFs​

An Integer specifying the ul d o fs.

The default value is 63.

dlVirtualNodePos​

A Double List specifying the virtual node position.

The default value is [0, 0, 0].

iSurfaceDef​

An Integer specifying the surface definition.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

iEnableUpdateDispCS​

An Integer specifying the enable update displacement coordinate system.

The default value is 1.

iEnableCornerOnly​

An Integer specifying the enable corner only.

The default value is 0.

iDuplicateMode​

An Integer specifying the duplicate mode.

The default value is -1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.RigidElements.RBE2General(iMethod, crlMasterTargets, crlSlaveTargets, iEType=2, strName="RBE2_1", crCoordSys=None, dTolerance=0.0, iUlDOFs=63, dlVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, iEnableUpdateDispCS=1, iEnableCornerOnly=0, iDuplicateMode=-1)
