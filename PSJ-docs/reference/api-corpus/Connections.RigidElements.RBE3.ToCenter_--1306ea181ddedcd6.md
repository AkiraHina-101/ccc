# Connections.RigidElements.RBE3.ToCenter()

Connections.RigidElements.RBE3.ToCenter()

Description​

Create one to many (Slave:Master) RBE3 (Interpolation constraining Element).

Syntax​

Connections.RigidElements.RBE3.ToCenter(...)

Ribbon: Connections » RigidElements » RBE3 » ToCenter

Inputs​

iMethod​

An Integer specifying the method.

The default value is 18.

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

An Integer specifying the type rbe3.

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

dlVirtualNodePos​

A Double List specifying the virtual node position.

The default value is [0, 0, 0].

iSurfaceDef​

An Integer specifying the surface definition.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

bUpdateDispCS​

A Boolean specifying the enable update displacement coordinate system.

The default value is True.

bCornerOnly​

A Boolean specifying the enable corner only.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cylinder(bHollow=True, dTopInnerRadius=0.005, dBottomInnerRadius=0.005, iPartColor=15658599)

Connections.RigidElements.RBE3.ToCenter(crlMasterTargets=[Edge(1)], 
                                    listRbe3TermConnection=[(0, 63, 1), (1, 7, 1)], 
                                    strName="RBE3_1", 
                                    dlVirtualNodePos=[0, 0.01, 0])
