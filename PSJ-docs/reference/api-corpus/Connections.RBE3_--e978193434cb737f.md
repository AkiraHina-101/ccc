# Connections.RBE3()

Connections.RBE3()

Description​

Unknown Description

Syntax​

Connections.RBE3(...)

Macro: Rbe3

Ribbon: Connections » RBE3

Inputs​

iMethod​

An Integer specifying the method.

The default value is 0.

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target.

The default value is [].

listRbe3TermConnection​

A RBE3TERM_CONNECTION List specifying the rbe3 term connection.

The default value is [].

iTypeRBE3​

An Integer specifying the type r e3.

The default value is 3.

strName​

A String specifying the name.

The default value is "".

crCoordSys​

A Cursor specifying the coordinate system.

The default value is None.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

posVirtualNodePos​

A Position specifying the virtual node position.

The default value is [0, 0, 0].

iSurfaceDef​

An Integer specifying the surface definition.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

bUpdateDispCS​

A Boolean specifying the update displacement coordinate system.

The default value is True.

bCornerOnly​

A Boolean specifying the corner only.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.RBE3(iMethod=0, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName="", crCoordSys=None, dTolerance=0.0, posVirtualNodePos=[0, 0, 0], iSurfaceDef=0, crEdit=None, bUpdateDispCS=True, bCornerOnly=False)
