# Connections.RigidElements.RBar.OneToOne()

Connections.RigidElements.RBar.OneToOne()

Description​

Create one-to-one (master:slave) RBar (rigid elements).

Syntax​

Connections.RigidElements.RBar.OneToOne(...)

Macro: RBarOneToOne

Ribbon: Connections » RigidElements » RBar » OneToOne

Inputs​

strName​

A String specifying the RBar name to be created.

The default value is "RBAR_1".

crlMasterTargets​

A List of Cursor specifying the master target. Master target can be selected by part, face, edge, element, or node.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target. Slave target can be selected by part, face, edge, element, or node.

The default value is [].

iMethod​

An Integer specifying the connection method.

The default value is 17.

iUlDOFs​

An Integer specifying the master degrees of freedom. This function only support case where all components of the independent degrees of freedom are fixed for the nodes selected in the master.

The default value is 0.

dTol​

A Double specifying the tolerance.

The default value is DFLT_DBL.

crCoord​

A Cursor specifying the coordinate system.

The default value is None.

bUpdateDispCS​

A Boolean specifying whether or not update displacement coordinate system.

If True, the displacement coordinate system is updated.

If False, displacement coordinate system is not updated.

The default value is True.

crEdit​

A Cursor specifying an existing Rbar

If this parameter is used, the specified Rbar will be modified.

If it is left None, a new Rbar will be created.

The default value is None.

Return Code​

A Cursor specifying the created Rbar.

Sample Code​

# Prepare models
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# Create the connections
rbar_connection = Connections.RigidElements.RBar.OneToOne(strName="RBar_1", crlMasterTargets=[Node(496)], 
                                    crlSlaveTargets=[Node(7)], iUlDOFs=63, dTol=0.0, bUpdateDispCS=True)
JPT.Debugger(rbar_connection)
