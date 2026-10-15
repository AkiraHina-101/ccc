# Connections.RigidElements.RigidBodyConstraint.NodesToBody()

Connections.RigidElements.RigidBodyConstraint.NodesToBody()

Description​

Create Rigid Body Constraint (LS-DYNA)

Syntax​

Connections.RigidElements.RigidBodyConstraint.NodesToBody(...)

Macro:

Ribbon: Connections » RigidElements » RigidBodyConstraint » NodesToBody

Inputs​

strName​

A String specifying the name of Rigid Body Constraint.

The default value is "RBC".

iMethod​

An Integer specifying type.

1: Node.

2: Node set.

The default value is 0.

crlMasters​

A List of Cursor specifying master entities.

The default value is [].

crlSlaves​

A List of Cursor specifying slave entities.

The default value is [].

crEdit​

A Cursor specifying existing Rigid Body Constraint.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Connections.RigidElements.RigidBodyConstraint.NodesToBody(
    strName="RBC_1", 
    iMethod=1, 
    crlMasters=[Part(1)], 
    crlSlaves=[Node(460)])
