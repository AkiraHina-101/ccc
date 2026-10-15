# Connections.MPC.General.NodesWithTolerance()

Connections.MPC.General.NodesWithTolerance()

Description​

Create a one-to-one MPC pair between multiple selected nodes within an arbitrary tolerance.

Syntax​

Connections.MPC.General.NodesWithTolerance(...)

Macro: Mpc

Ribbon: Connections » MPC » General » NodesWithTolerance

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterNodes​

A List of Cursor specifying the list of nodes which need to be connected.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the pair of MPC connection data type.

The default value is [].

dSearchTol​

A Double specifying the MPC search tolerance value.

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

created_mpc = Connections.MPC.General.NodesWithTolerance(strName="MPC_6",
                                                         crlMasterNodes=[Node(324, 766)], 
                                                         listMpcConnection=[MPC_CONNECTION(iDof=1),
                                                                            MPC_CONNECTION(iDof=2), 
                                                                            MPC_CONNECTION(iDof=4), 
                                                                            MPC_CONNECTION(), 
                                                                            MPC_CONNECTION(),
                                                                            MPC_CONNECTION()], 
                                                         dSearchTol=0.02, 
                                                         bUpdateDispCS=1)

JPT.Debugger(created_mpc)
