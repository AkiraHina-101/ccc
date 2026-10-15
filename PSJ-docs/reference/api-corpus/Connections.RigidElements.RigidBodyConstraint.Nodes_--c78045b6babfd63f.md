# Connections.RigidElements.RigidBodyConstraint.Nodes()

Connections.RigidElements.RigidBodyConstraint.Nodes()

Description​

Create Rigid Body Constraint (LS-DYNA)

Syntax​

Connections.RigidElements.RigidBodyConstraint.Nodes(...)

Macro:

Ribbon: Connections » RigidElements » RigidBodyConstraint » Nodes

Inputs​

strName​

A String specifying the name of Rigid Body Constraint.

The default value is "RBC".

iMethod​

An Integer specifying method. Is is set 3 for this function.

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
Connections.RigidElements.RigidBodyConstraint.Nodes(
    strName="RBC_1", 
    iMethod=3, 
    crlMasters=[Edge(15)])
