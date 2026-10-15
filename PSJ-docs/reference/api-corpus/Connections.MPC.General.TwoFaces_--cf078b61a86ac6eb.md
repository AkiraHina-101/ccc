# Connections.MPC.General.TwoFaces()

Connections.MPC.General.TwoFaces()

Description​

Create MPC between two faces.

Syntax​

Connections.MPC.General.TwoFaces(...)

Macro: Mpc

Ribbon: Connections » MPC » General » TwoFaces

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crMasterFace​

A Cursor specifying the master face. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

The default value is None.

crSlaveFace​

A Cursor specifying the slave face. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

The default value is None.

listMpcConnection​

A List of MPC_CONNECTION specifying the pair of MPC connection data type.

The default value is [].

iLocalCoordinate​

An Integer specifying the local coordinate system.

The default value is 0.

bUpdateDispCS​

A Boolean specifying whether or not update displacement coordinate system at nodes belongs to selected faces to the specified local coordinate system.

If True, the displacement coordinate system is updated.

If False, displacement coordinate system is not updated.

The default value is True.

crMPCConnection​

A Cursor specifying the exist MPC for editing. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

If this parameter is used, the specified exist MPC item will be modified.

If it is left None, a new MPC item will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified MPC connection (2 Faces).

Sample Code​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.TwoFaces(strName="MPC_12", 
                                               crMasterFace=Face(49),
                                               crSlaveFace=Face(24), 
                                               listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                  MPC_CONNECTION(iDof=2),
                                                                  MPC_CONNECTION(iDof=4), 
                                                                  MPC_CONNECTION(), 
                                                                  MPC_CONNECTION(),
                                                                  MPC_CONNECTION()], 
                                               bUpdateDispCS=1)

JPT.Debugger(created_mpc)
