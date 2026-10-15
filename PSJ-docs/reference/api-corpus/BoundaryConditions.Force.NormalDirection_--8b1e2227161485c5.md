# BoundaryConditions.Force.NormalDirection()

BoundaryConditions.Force.NormalDirection()

Description​

Create a force in the normal direction applies on selected Face, Edge, Node/MidNode, Normal(Element). User inputs the force value, and it will apply the force to the selected items.

Syntax​

BoundaryConditions.Force.NormalDirection(...)

Ribbon: Boundary Conditions » Force » Normal Direction

Inputs​

strName​

A String specifying the name of the force setting.

The default value is "ForceNormal1".

dForce​

A Double specifying the total force value (default unit: N).

The default value is 0.

crElemForNormal​

A Cursor specifying a 2D element. This element will be used to calculate vector normal for force direction.

iArrowDir​

An Integer specifying the display arrow direction. This parameter only affects the display of the force setting, the force itself remains intact. The value for this parameter is one of the following.

0: Start at node.

1: End at node.

The default value is 0.

iDistributeType​

An Integer specifying the force distribution method. The value for this parameter is one of the following.

0: Per selected entity. Each selected item (Face, Edge, Node) receives the same amount of the specified force. For example, a vector force [1; 0; 2] is applied on 2 faces, then each face will receive a vector force [1; 0; 2].

1: Per selected node. Each nodes in selected items (Face, Edge, Node) receives the same amount of the specified force. For example, a vector force [1; 0; 2] is applied on 1 edge, which has 10 nodes, then each node will receive a vector force [1; 0; 2].

2: Total of selected entity. Each selected item (Face, Edge, Node) receives the same amount of force, which is the specified force divided by the number of selected entity. For example, a vector force [1; 0; 2] is applied on 2 faces, then each face will receive a vector force [0.5; 0; 1].

The default value is 0.

crCoord​

A Cursor specifying the coordinate from which the fixed constraint is created.

The default value is None(global coordinate system).

crlTargets​

A List of Cursor specifying the list of targets for normal direction force. This target can be Face, Edge, Node/MidNode, Normal(Element).

The default value is [].

crEdit​

A Cursor specifying an existing normal direction force. If this parameter is used, the specified normal direction force will be modified. If it is left None, a new normal direction force will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.Force.NormalDirection(strName="ForceNormal1", 
                                                       dForce=1, 
                                                       crElemForNormal=Elem(1008),
                                                       crlTargets=[Face(26)])

JPT.Debugger(created_bcs)
