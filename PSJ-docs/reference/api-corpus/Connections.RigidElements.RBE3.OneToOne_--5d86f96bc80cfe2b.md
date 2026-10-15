# Connections.RigidElements.RBE3.OneToOne()

Connections.RigidElements.RBE3.OneToOne()

Description​

Create one to one (Slave:Master) RBE3 (Interpolation constraining Element).

Syntax​

Connections.RigidElements.RBE3.OneToOne(...)

Ribbon: Connections » RigidElements » RBE3 » OneToOne

Inputs​

iMethod​

An Integer specifying the method.

The default value is 17.

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

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(
    ilAxialNodes=[4, 4, 4], strName="Cube_2", iPartColor=14903267)

Geometry.Part.Cube(
    dlOrigin=[0.012, 0.0, 0.0], 
    ilAxialNodes=[4, 4, 4], 
    strName="Cube_3", 
    iPartColor=7829501)

Connections.RigidElements.RBE3.OneToOne(
    crlMasterTargets=[Node(61, 87, 88, 64, 57, 71, 72, 60)], 
    crlSlaveTargets=[Node(6, 27, 28, 7, 2, 11, 12, 3)],
     listRbe3TermConnection=[(0, 63, 8), (1, 7, 8)],
     strName="RBE3_3")
