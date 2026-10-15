# Connections.MPC.General.NodeToAny()

Connections.MPC.General.NodeToAny()

Description​

Create MPC between a selected node and any types of entities such as nodes, edges or faces.

Syntax​

Connections.MPC.General.NodeToAny(...)

Macro: Mpc

Ribbon: Connections » MPC » General » NodeToAny

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crMasterNode​

A Cursor specifying the master node which needs to be connected.

The default value is None.

crlSlaveEntities​

A List of Cursor specifying the list of slave entities such as nodes, edges or faces which need to be connected. The slave entities list can contain different types of entities at the same time.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the pair of MPC connection data type.

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

A Cursor specifying the exist MPC for editing.

If this parameter is used, the specified exist MPC item will be modified.

If it is left None, a new MPC item will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified MPC connection.

Sample Code​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.NodeToAny(strName="MPC_7", 
                                                crMasterNode=Node(757),
                                                crlSlaveEntities=[Node(333), 
                                                                  Edge(14)], 
                                                listMpcConnection=[MPC_CONNECTION(iDof=1),
                                                                   MPC_CONNECTION(iDof=2), 
                                                                   MPC_CONNECTION(iDof=4), 
                                                                   MPC_CONNECTION(), 
                                                                   MPC_CONNECTION(),
                                                                   MPC_CONNECTION()], 
                                                bUpdateDispCS=1)

JPT.Debugger(created_mpc)
