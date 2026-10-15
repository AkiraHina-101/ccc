# Connections.Pretension.Advc()

Connections.Pretension.Advc()

Description​

Create bolt pretension for the ADVC solver.

Syntax​

Connections.Pretension.Advc(...)

Ribbon: Connections » Pretension » Advc

Inputs​

crlTargets​

A List of Cursor specifying the list of targets. It can be faces or 1D elements.

This is a required input.

dForceValue​

A Double specifying the value of pretension force.

This is a required input.

dlForceDirection​

A List of Double specifying the bolt tightening direction.

This is a required input.

dlControlNode​

A List of Double specifying the position of control node.

This is a required input.

strName​

A String specifying the name of pretension force.

The default value is "PreTensionAdvc1".

bFixedLength​

A Boolean specified whether or not the tightening force of the bolt option are retained.

The default value is False.

crLbcEnforcedVelocity​

A Cursor specifying the existing enforced velocity of the pretension force (ADVC) to be edited. This argument must be specified when crLbcPretensionADVC is specified.

The default value is None.

iDirectionUpdate​

An Integer specifying whether or not the tightening direction has been updated.

If iDirectionUpdate=0, this argument is ignored.

If iDirectionUpdate=1, update the tightening direction.

If iDirectionUpdate=2, do not update the tightening direction.

The default value is 0.

iRefNodeId​

An Integer specifying the ID of reference node.

The default value is 0.

crLbcPretensionADVC​

A Cursor specifying an existing pretension force (ADVC).

If this parameter is used, the specified pretension force (ADVC) will be modified.

If it is left None, a new pretension force (ADVC) will be created.

The default value is None.

Return Code​

A Cursor specifying the created ADVC pretension.

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

creating_status = Connections.Pretension.Advc(crlTargets=[Face(8)], 
                                              dForceValue=1.0, 
                                              dlForceDirection=[0.0, -1.0, 0.0], 
                                              dlControlNode=[0.001419156, 0.02, 0.00012416],
                                              iRefNodeId=442)
JPT.Debugger(creating_status)
