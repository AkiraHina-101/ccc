# MeshEdit.CreateNode.Point()

MeshEdit.CreateNode.Point()

Description​

Create a node by referring to the coordinate value of the arbitrary point.

Syntax​

MeshEdit.CreateNode.Point(...)

Macro: MeshEditCreateNodePoint

Ribbon: MeshEdit » CreateNode » Point

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

posPoint​

A List of Double specifying the coordinates of the specified point.

The default value is [0,0,0].

bImprint​

A Boolean specifying to imprint node to face.

The default value is True.

crTarget​

A Cursor specifying the target on which to create the node. The target can be a face or an edge.

The default value is None.

Return Code​

A Cursor specifying the created floating or imprinted node.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create node at point
newNode = MeshEdit.CreateNode.Point(iNewNodeID=490, 
                                    posPoint=[0.008331683464348316, 0.003326606005430222, 0.009999999776482582], 
                                    bImprint=False, crTarget=Face(26))
JPT.Debugger(newNode) # for checking the return value
