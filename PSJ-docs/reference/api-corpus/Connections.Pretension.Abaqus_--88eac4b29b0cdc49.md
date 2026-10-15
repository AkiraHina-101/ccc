# Connections.Pretension.Abaqus()

Connections.Pretension.Abaqus()

Description​

Create bolt pretension for the Abaqus solver.

Syntax​

Connections.Pretension.Abaqus(...)

Macro: PretensionAbaqus

Ribbon: Connections » Pretension » Abaqus

Inputs​

crTargets​

A Cursor specifying the faces or the element for creating the pretension force.

This is a required input.

dForceValue​

A Double specifying the value of pretension force.

This is a required input.

dlForceDirection​

A List of Double specifying the direction of pretension force.

This is a required input.

dlControlNode​

A List of Double specifying the position of the control node.

This is a required input.

strName​

A String specifying the name of pretension force.

The default value is "PreTensionAbaqus1".

bFixedLength​

A Boolean specified whether or not the tightening force of the bolt option are retained.

The default value is False.

crLbcConstraint​

A Cursor specifying the existing Fixed Constraint object of pretension force to be edited. This argument must be specified when crLbcPretensionAbaqus is specified. Otherwise, a new Fixed Constraint object will be created.

The default value is None.

crLbcPretensionAbaqus​

A Cursor specifying an existing pretension force (Abaqus). If no pretension force is specified, a new one will be created, otherwise, the specified pretension force (Abaqus) will be modified.

The default value is None.

iRefNodeID​

An Int specified the reference node.

This is a required input.

Return Code​

A Cursor specifying the created Abaqus pretension.

Sample Code​

Geometry.Part.Cylinder(dHeight=0.04,
                       iPartColor=6447843)
MeshEdit.CreateNode.Between2Nodes(iNodeID=363,
                                  dX=7.66044e-06, 
                                  dY=2e-05, 
                                  dZ=-6.42788e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(65, 
                                                 66)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=364, 
                                  dX=-1.73648e-06, 
                                  dY=2e-05, 
                                  dZ=9.84808e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(21, 
                                                 22)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=365, 
                                  dX=-3.4202e-06, 
                                  dY=2e-05, 
                                  dZ=-9.39693e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(51, 
                                                 52)])
Geometry.BodyCut.By3Points(crPart=Part(1), 
                           poslPoints=[[-0.003420201433256686, 0.02, -0.009396926207859084], 
                                       [0.007660444431189778, 0.02, -0.006427876096865396], 
                                       [-0.001736481776669303, 0.02, 0.00984807753012208]], 
                           bSplitOnly=True)
MeshEdit.DeleteNode()

max_node_id=JPT.GetMaxIDEntity(JPT.EntityType.NODE)

creating_status = Connections.Pretension.Abaqus(crlTargets=[Face(11)], 
                                                dForceValue=1000000.0, 
                                                dlForceDirection=[0.000000,
                                                                  -1.000000,
                                                                  0.000000],
                                                dlControlNode=[0.001419156, 
                                                               0.02, 
                                                               0.00012416],
                                                iRefNodeID=max_node_id+1)

JPT.Debugger(creating_status)
