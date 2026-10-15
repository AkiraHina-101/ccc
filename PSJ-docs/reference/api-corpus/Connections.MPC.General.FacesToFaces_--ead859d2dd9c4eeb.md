# Connections.MPC.General.FacesToFaces()

Connections.MPC.General.FacesToFaces()

Description​

Create MPC by connecting selected faces together.

Syntax​

Connections.MPC.General.FacesToFaces(...)

Macro: Mpc

Ribbon: Connections » MPC » General » FacesToFaces

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterFaces​

A List of Cursor specifying the list of the master faces which need to be connected. The master list can contain one or many faces.

In case the master list has more than one face, the number of master faces and slave faces must be equal. The MPC is created by connecting the selected master faces with the selected slave faces one by one correspondingly.

This is the required input.

crlSlaveFaces​

A List of Cursor specifying the list of the slave faces which need to be connected. The slave list can contain one or many faces.

In case the slave list has more than one face, the number of slave faces and master faces must be equal. The MPC is created by connecting the selected master faces with the selected slave faces one by one correspondingly.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the list of MPC connection.

The default value is [].

iLocalCoordinate​

An Integer specifying the local coordinate system.

The default value is 0.

bUpdateDispCS​

A Boolean specifying the update displacement coordinate system.

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

created_mpc = Connections.MPC.General.FacesToFaces(strName="MPC_10", 
                                                   crlMasterFaces=[Face(24)],
                                                   crlSlaveFaces=[Face(49)], 
                                                   listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                      MPC_CONNECTION(iDof=2),
                                                                      MPC_CONNECTION(iDof=4), 
                                                                      MPC_CONNECTION(), 
                                                                      MPC_CONNECTION(), 
                                                                      MPC_CONNECTION()], 
                                                   bUpdateDispCS=1, 
                                                   crMPCConnection=None)

JPT.Debugger(created_mpc)
