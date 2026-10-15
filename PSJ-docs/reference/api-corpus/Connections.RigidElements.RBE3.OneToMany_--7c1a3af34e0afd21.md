# Connections.RigidElements.RBE3.OneToMany()

Connections.RigidElements.RBE3.OneToMany()

Description​

Create one to many (Slave:Master) RBE3 (Interpolation constraining Element).

Syntax​

Connections.RigidElements.RBE3.OneToMany(...)

Ribbon: Connections » RigidElements » RBE3 » OneToMany

Inputs​

iMethod​

An Integer specifying the method.

The default value is 16.

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

bCornerOnly​

A Boolean specifying the enable corner only.

The default value is False.

Return Code​

A Cursor specifying the created RBE3 connection.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=14903267)

# Create the connection
Connections.RigidElements.RBE3.OneToMany(crlMasterTargets=[Node(589, 496, 493)], 
                                        crlSlaveTargets=[Node(84)], 
                                        listRbe3TermConnection=[(0, 63, 1), (1, 7, 3)], 
                                        strName="RBE3_1")
