# Connections.MPC.General.NodesToNodes()

Connections.MPC.General.NodesToNodes()

Description​

Create MPC between selected nodes.

Syntax​

Connections.MPC.General.NodesToNodes(...)

Macro: Mpc

Ribbon: Connections » MPC » General » NodesToNodes

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterNodes​

A List of Cursor specifying the list of master nodes.

In case this list has more than one selected node, the number of master nodes and slave nodes must be equal. The MPC is created by connecting selected master nodes with selected slave nodes one-to-one correspondingly.

This is the required input.

crlSlaveNodes​

A List of Cursor specifying the list of slave nodes.

In case this list has more than one selected node, the number of slave nodes and master nodes must be equal. The MPC is created by connecting selected master nodes with selected slave nodes correspondingly.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the pair of MPC connection data type.

The default value is [].

dSearchTol​

A Double specifying the MPC search tolerance value.

The default value is 0.0.

dValue​

A Double specifying the MPC value.

The default value is 0.0.

iMPCType​

An Integer specifying the MPC type.
0: MPC General.

1: MPC Equation.

The default value is 0.

iSearchType​

An Integer specifying the search type.

The default value is 1.

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

created_mpc = Connections.MPC.General.NodesToNodes(strName="MPC_5", 
                                                   crlMasterNodes=[Node(760, 
                                                                        770)],
                                                   crlSlaveNodes=[Node(323, 
                                                                       310)], 
                                                   listMpcConnection=[MPC_CONNECTION(dCoef=1.0, 
                                                                                     iDof=1),
                                                                      MPC_CONNECTION(dCoef=1.0, 
                                                                                     iDof=2), 
                                                                      MPC_CONNECTION(dCoef=1.0, 
                                                                                     iDof=4), 
                                                                      MPC_CONNECTION(),
                                                                      MPC_CONNECTION(), 
                                                                      MPC_CONNECTION()], 
                                                   bUpdateDispCS=1)

JPT.Debugger(created_mpc)
