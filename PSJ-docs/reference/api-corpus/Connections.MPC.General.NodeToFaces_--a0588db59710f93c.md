# Connections.MPC.General.NodeToFaces()

Connections.MPC.General.NodeToFaces()

Description​

Create a MPC between a node and multiple faces.

Syntax​

Connections.MPC.General.NodeToFaces(...)

Macro: Mpc

Ribbon: Connections » MPC » General » NodeToFaces

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crMasterNode​

A Cursor specifying the unique master node which needs to be connected.

This is the required input.

crlSlaveFaces​

A List of Cursor specifying the list of slave faces which need to be connected. The master node will connect to all nodes on the edges of slave faces.

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

created_mpc = Connections.MPC.General.NodeToFaces(strName="MPC_9", 
                                                  crMasterNode=Node(758),
                                                  crlSlaveFaces=[Face(24)], 
                                                  listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                     MPC_CONNECTION(iDof=2),
                                                                     MPC_CONNECTION(iDof=4), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION()],
                                                  bUpdateDispCS=1)

JPT.Debugger(created_mpc)
