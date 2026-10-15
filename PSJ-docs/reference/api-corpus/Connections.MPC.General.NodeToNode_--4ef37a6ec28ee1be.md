# Connections.MPC.General.NodeToNode()

Connections.MPC.General.NodeToNode()

Description​

Create a MPC connection between slave nodes to master nodes one-to-one correspondingly. The sequence of nodes selection is the first master node, the first slave node, the second master node, the second slave node and so on.

Syntax​

Connections.MPC.General.TwoNodes(...)

Macro: Mpc

Ribbon: Connections » MPC » General » NodeToNode

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterNodes​

A List of Cursor specifying the list of master nodes which need to be connected. The master list can contain one or many nodes.

In case the list has more than one face, the number of master nodes and slave nodes must be equal. The MPC is created by connecting the selected master nodes with the selected slave nodes one by one correspondingly.

This is the required input.

crlSlaveNodes​

A List of Cursor specifying the list of slave nodes which need to be connected. The slave list can contain one or many nodes.

In case the list has more than one face, the number of master nodes and slave nodes must be equal. The MPC is created by connecting the selected master nodes with the selected slave nodes one by one correspondingly.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the list of MPC connection.

The default value is [].

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

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.TwoNodes(strName="MPC_10", 
                                               crlMasterNodes=[Node(757)],
                                               crlSlaveNodes=[Node(347)], 
                                               listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                  MPC_CONNECTION(iDof=2),
                                                                  MPC_CONNECTION(iDof=4), 
                                                                  MPC_CONNECTION(), 
                                                                  MPC_CONNECTION(), 
                                                                  MPC_CONNECTION()],
                                               bUpdateDispCS=1)

JPT.Debugger(created_mpc)
