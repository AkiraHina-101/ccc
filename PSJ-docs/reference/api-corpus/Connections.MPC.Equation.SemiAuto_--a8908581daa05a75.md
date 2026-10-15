# Connections.MPC.Equation.SemiAuto()

Connections.MPC.Equation.SemiAuto()

Description​

Creates the MPC between the nodes with a distance tolerance.

Syntax​

Connections.MPC.Equation.SemiAuto(...)

Macro: Mpc

Ribbon: Connections » MPC » Equation » SemiAuto

Inputs​

strName​

A String specifying the MPC name.

The default value is "MPC_1".

crlMasterEntities​

A List of Cursor specifying the list of master entities. The entities could be any of types such as Parts/Faces/Edges/Nodes.

This is the required input.

crlSlaveEntities​

A List of Cursor specifying the list of slave entities. The entities could be any of types such as Parts/Faces/Edges/Nodes.

This is the required input.

listMpcConnection​

A List of MPC_CONNECTION specifying the list of MPC connection.

The default value is [].

dConstantValue​

A Double specifying the MPC value.

The default value is 0.0.

iLocalCoordinate​

An Integer specifying the coordinate system.

The default value is 0.

bUpdateDispCS​

A Boolean specifying whether or not update displacement coordinate system.

The default value is True.

crMpcConnection​

A Cursor specifying an existing contact setting (MPC Equation). If this parameter is used, the specified contact setting (MPC Equation) will be modified. When the default value is used, a new contact setting (MPC Equation) will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified contact connection.

Sample Code​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.Equation.SemiAuto(crlMasterEntities=[Face(24)], 
                                                crlSlaveEntities=[Face(49)], 
                                                listMpcConnection=[MPC_CONNECTION(dCoef=20.0, 
                                                                                  iDof=1), 
                                                                   MPC_CONNECTION(dCoef=-20.0, 
                                                                                  iDof=1)], 
                                                dConstantValue=10.0, 
                                                bUpdateDispCS=1)

JPT.Debugger(created_mpc)
