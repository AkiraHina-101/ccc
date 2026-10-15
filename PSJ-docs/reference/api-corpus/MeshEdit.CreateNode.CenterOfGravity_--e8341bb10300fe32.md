# MeshEdit.CreateNode.CenterOfGravity()

MeshEdit.CreateNode.CenterOfGravity()

Description​

Create node Center Of Gravity

Syntax​

MeshEdit.CreateNode.CenterOfGravity(iCreationType=1, iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, crlParts=[], crlBarPart=[], crlFaces=[])

Ribbon: MeshEdit » CreateNode » CenterOfGravity

Inputs​

iCreationType​

An Integer specifying the creation type.

The default value is 1.

iNodeID​

An Integer specifying the node ID.

The default value is 0.

dX​

A Double specifying the x.

The default value is 0.0.

dY​

A Double specifying the y.

The default value is 0.0.

dZ​

A Double specifying the z.

The default value is 0.0.

crlParts​

A List of Cursor specifying the part.

The default value is [].

crlBarPart​

A List of Cursor specifying the bar part.

The default value is [].

crlFaces​

A List of Cursor specifying the face.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.CenterOfGravity(iCreationType=1, iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, crlParts=[], crlBarPart=[], crlFaces=[])
