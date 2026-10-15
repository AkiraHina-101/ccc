# Connections.MPC.General.TwoEdges()

Connections.MPC.General.TwoEdges()

Description​

Create MPC between two edges.

Syntax​

Connections.MPC.General.TwoEdges(...)

Macro: Mpc

Ribbon: Connections » MPC » General » TwoEdges

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crMasterEdge​

A List of Cursor specifying the list of master edges which need to be connected.

This is the required input.

crSlaveEdge​

A List of Cursor specifying the list of slave edges which need to be connected.

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

created_mpc = Connections.MPC.General.TwoEdges(strName="MPC_11", 
                                               crMasterEdge=Edge(46),
                                               crSlaveEdge=Edge(10), 
                                               listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                  MPC_CONNECTION(iDof=2),
                                                                  MPC_CONNECTION(iDof=4), 
                                                                  MPC_CONNECTION(iDof=8), 
                                                                  MPC_CONNECTION(),
                                                                  MPC_CONNECTION(iDof=32)], 
                                               bUpdateDispCS=1)

JPT.Debugger(created_mpc)
