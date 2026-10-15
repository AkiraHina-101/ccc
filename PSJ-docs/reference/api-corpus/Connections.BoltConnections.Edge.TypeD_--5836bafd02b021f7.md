# Connections.BoltConnections.Edge.TypeD()

Connections.BoltConnections.Edge.TypeD()

Description​

Create Lbc TypeD Bolt Edge method.

Syntax​

Connections.BoltConnections.Edge.TypeD(...)

Ribbon: Connections » BoltConnections » Edge » TypeD

Inputs​

crlEdgeCur1​

A List of Cursor specifying the edge cur1.

This is a required input.

crlEdgeCur2​

A List of Cursor specifying the edge cur2.

This is a required input.

strMpcName​

A String specifying the mpc name.

The default value is "MPC".

dConnRadius​

A Double specifying the conn radius.

The default value is 0.0.

dPlaneTol​

A Double specifying the plane tolerance.

The default value is 20.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltConnections.Edge.TypeD(crlEdgeCur1, crlEdgeCur2, strMpcName="MPC", dConnRadius=0.0, dPlaneTol=20.0)
