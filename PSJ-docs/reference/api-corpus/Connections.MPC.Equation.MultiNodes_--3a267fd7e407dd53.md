# Connections.MPC.Equation.MultiNodes()

Connections.MPC.Equation.MultiNodes()

Description​

Create a MPC connection between a slave node with multi-master nodes.

Syntax​

Connections.MPC.Equation.MultiNodes(...)

Macro: Mpc

Ribbon: Connections » MPC » Equation » MultiNodes

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterNodes​

A List of Cursor specifying the list of master nodes which need to be connected. The master nodes are the nodes from the second selected node onwards in the selection list of nodes.

This is the required input.

crSlaveNode​

A Cursor specifying the slave node which needs to be connected. The slave node is the first selected node in the selection list of nodes. This slave node will connect to all master nodes.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the list of MPC connection.

The default value is [].

dValue​

A Double specifying the MPC value.

The default value is 0.0.

iLocalCoordinate​

An Integer specifying the local coordinate system.

The default value is 0.

bUpdateDispCS​

A Boolean specifying whether or not update displacement coordinate system.
If True, the displacement coordinate system is updated.

If False, displacement coordinate system is not updated.

The default value is True.

crMPCConnection​

A Cursor specifying an existing MPC connection.
If this parameter is used, the specified MPC connection will be modified.

If it is left None, a new MPC connection will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified MPC connection.

Sample Code​

Geometry.Part.Cube(iPartColor = 7666683)
Geometry.Part.Cube(dlOrigin = [0.02, 0.0, 0.0], 
                   strName = "Cube_2", 
                   iPartColor = 12867524)

created_mpc = Connections.MPC.Equation.MultipleNodes(crlMasterNodes=[Node(340,
                                                                          344, 
                                                                          353)],
                                                     crSlaveNode=Node(757), 
                                                     listMpcConnection=[MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1),
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1), 
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1),
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1)], 
                                                     bUpdateDispCS=1)

JPT.Debugger(created_mpc)
