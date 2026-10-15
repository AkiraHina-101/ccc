# Connections.MPC.Equation.TwoFaces()

Connections.MPC.Equation.TwoFaces()

Description​

Create MPC between multiple points of two faces.

Syntax​

Connections.MPC.Equation.TwoFaces(...)

Macro: Mpc

Ribbon: Connections » MPC » Equation » TwoFace

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crMasterFace​

A Cursor specifying the face to be master. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

The default value is None.

crSlaveFace​

A Cursor specifying the face to be  slave. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

The default value is None.

listMpcConnection​

A List of MPC_CONNECTION specifying the pair of MPC connection data type.

The default value is [].

dValue​

A Double specifying the MPC constant value.

The default value is 0.0.

iLocalCoordinate​

An Integer specifying the local coordinate system.

The default value is 0.

bUpdateDispCS​

A Boolean specifying whether to change the Displacement Coordinate system at nodes belongs to selected faces to the specified local coordinate system.

The default value is True.

crMPCConnection​

A Cursor specifying an existing MPC Connection (2 Faces). If this argument is not None, the specified MPC Connection will be modified. Otherwise, a new MPC Connection will be created. The couple crMasterFace, crSlaveFace and crMPCConnection arguments are mutually exclusive. One of them must be specified.

The default value is None.

Return Code​

A Cursor specifying the created or the modified MPC connection.

Sample Code​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.Equation.TwoFaces(strName="MPC_1", 
                                                crMasterFace=Face(49), 
                                                crSlaveFace=Face(24),
                                                listMpcConnection=[MPC_CONNECTION(dCoef=1.0, 
                                                                                  iDof=1), 
                                                                   MPC_CONNECTION(dCoef=-1.0, 
                                                                                  iDof=1)], 
                                                bUpdateDispCS=1)

JPT.Debugger(created_mpc)
