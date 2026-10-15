# Connections.Connector()

Connections.Connector()

Description​

Create connectors between nodes, edges, and faces according to specified connection types. User selects master/slave targets and the connectors will be created to connect nodes on master/slave targets with each other.

Syntax​

Connections.Connector(...)

Macro: Connector

Ribbon: Connections » Connector

Inputs​

strName​

A String specifying the connection name to be created.

The default value is "Connector_1".

iMethod​

An Integer specifying the connection method.

If iMethod=1, the method is Node to Node.

If iMethod=2, the method is Edge to Edge.

If iMethod=3, the method is Face to Face.

The default value is 1.

iConnectType​

An Integer specifying the connection type.

If iConnectType=0, the connection type is Parallel.

If iConnectType=1, the connection type is Translation.

If iConnectType=2, the connection type is Rotation.

If iConnectType=3, the connection type is Bushing.

If iConnectType=4, the connection type is Cylindrical.

If iConnectType=5, the connection type is Joint.

If iConnectType=6, the connection type is RigidRod.

If iConnectType=7, the connection type is RigidBar.

The default value is 0.

iRefNode​

An Integer specifying a node to refer to when determining the coordinate system.

If iRefNode=0, reference to the first node.

If iRefNode=1, reference to the second node.

The default value is 0.

iElemCs​

An Integer specifying the option whether or not an element coordinate system is used.

If iElemCs=0, do not use element coordinate system.

If iElemCs=1, use element coordinate system.

The default value is 0.

crLocalCS​

A Cursor specifying the local coordinate system.

The default value is None.

crlElasticity​

A List of Cursor specifying the table data of elastic property.

The default value is [].

crlDamp​

A List of Cursor specifying the table data of viscosity characteristics.

The default value is [].

crlMasterTargets​

A List of Cursor specifying the list of master targets.

The targets are nodes when the iMethod is equal to 1.

The targets are edges when the iMethod is equal to 2.

And the targets are faces when the iMethod is equal to 3.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the list of slave targets.

The targets are nodes when the iMethod is equal to 1.

The targets are edges when the iMethod is equal to 2.

And the targets are faces when the iMethod is equal to 3.

The default value is [].

crEdit​

A Cursor specifying an existing connection.

If this parameter is used, the specified connection will be modified.

If it is left None, a new connection will be created.

The default value is None.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube()

created_contact = Connections.Connector(strName="Connector_1", 
                                        iMethod=3, 
                                        crlElasticity=[Unknown(0, 
                                                               0, 
                                                               0, 
                                                               0,
                                                               0, 
                                                               0)], 
                                        crlDamp=[Unknown(0, 
                                                         0, 
                                                         0, 
                                                         0, 
                                                         0, 
                                                         0)], 
                                        crlMasterTargets=[Face(22)], 
                                        crlSlaveTargets=[Face(21)])

JPT.Debugger(created_contact)
