# JPT.GetAllConnections()

JPT.GetAllConnections()

Description​

Get all the information of all existing connections.

Syntax​

JPT.GetAllConnections()

Inputs​

This utility function does not require any input value.

Return Code​

A ConnectVector object or List of DConnect objects containing all the information of all the existing connections.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=13290083)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=6149981)
Geometry.Part.Cube(dlOrigin=[0.024, 0.0, 0.0], strName="Cube_3", iPartColor=7664244)
Geometry.Part.Cube(dlOrigin=[0.036, 0.0, 0.0], strName="Cube_4", iPartColor=13588687)
Geometry.Part.Cube(dlOrigin=[0.036, 0.012, 0.0], strName="Cube_5", iPartColor=14048091)
Geometry.Part.Cube(dlOrigin=[0.024, 0.012, 0.0], strName="Cube_6", iPartColor=7138156)
Geometry.Part.Cube(dlOrigin=[0.012, 0.012, 0.0], strName="Cube_7", iPartColor=5489235)
Geometry.Part.Cube(dlOrigin=[0.0, 0.012, 0.0], strName="Cube_8", iPartColor=7632109)
Connections.MPC.General.NodesToNodes(crlMasterNodes=[Node(1932)], crlSlaveNodes=[Node(1429)], listMpcConnection=[MPC_CONNECTION(iDof=1), MPC_CONNECTION(iDof=2), MPC_CONNECTION(iDof=4), MPC_CONNECTION(), MPC_CONNECTION(), MPC_CONNECTION()], bUpdateDispCS=1)
Connections.RigidElements.RBE2.OneToOne(crlMasterTargets=[Node(940)], crlSlaveTargets=[Node(3363)])
Connections.RigidElements.RBE3.OneToMany(crlMasterTargets=[Node(459, 3889, 3859)], crlSlaveTargets=[Node(3879)], listRbe3TermConnection=[(0, 63, 1), (1, 7, 3)], strName="RBE3_1")
Connections.SpringsDampers.Spring.OneToOne.sameDoFs(iMethod=17, strName="Spring_2", crlMasterTargets=[Node(2396)], crlSlaveTargets=[Node(2428)], iSpringType=2, posTStiffness=[1.7976931e+308, 1.7976931e+308, 1.7976931e+308], posRStiffness=[1.7976931e+308, 1.7976931e+308, 1.7976931e+308])
Connections.SpringsDampers.Bush.TwoNodes(crlMaster=[Node(2884)], crlSlave=[Node(2900)], iOriMode=1, poslVector=[0, 0, 0], dlStiffness=[DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL], dlDampCoef=[DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL], dlDampConst=[DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL, DFLT_DBL])
Connections.SpringsDampers.Damper.AnyEntities11DoFS(iMethod=17, strName="Damper_1", crlMasterTargets=[Node(3382)], crlSlaveTargets=[Node(3398)])
JPT.ViewFitToModel()

# Get all the existing connections
listDConnections = JPT.GetAllConnections()
JPT.Debugger(listDConnections)

# Print all the relating information of each existing connection in list
for connection in listDConnections:
    JPT.Debugger(connection)
