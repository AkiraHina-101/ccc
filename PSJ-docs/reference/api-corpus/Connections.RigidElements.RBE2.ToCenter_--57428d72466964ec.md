# Connections.RigidElements.RBE2.ToCenter()

Connections.RigidElements.RBE2.ToCenter()

Description​

Create one-to-many (master:slave) RBE2 (rigid element).

Syntax​

Connections.RigidElements.RBE2.ToCenter(...)

Macro: RBE2ToCenter

Ribbon: Connections » RigidElements » RBE2 » ToCenter

Inputs​

iMethod​

An Integer specifying the connection method.

The default value is 18.

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target. Slave target can be selected by part, face, edge, element, or node.

The default value is [].

iEType​

An Integer specifying the connection type.

The default value is 2.

strName​

A String specifying the RBE2 name to be created.

The default value is "RBE2_1".

crCoordSys​

A Cursor specifying the coordinate system.

The default value is None.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

iUlDOFs​

An Integer specifying the component of dependent degrees of freedom.

The default value is 63.

dlVirtualNodePos​

A Double List specifying the position of master node.

The default value is [0, 0, 0].

iSurfaceDef​

An Integer specifying the surface definition.

0: By Node Set - Specify the node as a reference surface.

1: By Element Set - Specify the element as a reference surface. Cannot configure an element to the slave entity (node, edge) and if it has been selected an error will be output.

The default value is 0.

crEdit​

A Cursor specifying an existing RBE2 connection

If this parameter is used, the specified RBE2 connection will be modified.

If it is left None, a new RBE2 will be created.

The default value is None.

iEnableUpdateDispCS​

An Integer specifying whether to update displacement coordinate system.

The default value is 1.

iEnableCornerOnly​

An Integer specifying whether to connect only to the corner nodes of the selected entity.

The default value is 0.

iEnableCheckDuplicate​

An Integer specifying whether to check for duplicate.

The default value is 1.

iDuplicateMode​

An Integer specifying the duplicate mode.

The default value is 0.

Return Code​

A Cursor specifying the created RBE2.

Sample Code​

# Prepare models
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# Create the connections
rbe2_connection = Connections.RigidElements.RBE2.ToCenter(crlSlaveTargets=[Node(496, 493, 489, 492, 7, 6, 2, 3)], 
                                         iUlDOFs=45, dlVirtualNodePos=[0.015, 0.005, 0.005], iEnableCornerOnly=1)
JPT.Debugger(rbe2_connection)
