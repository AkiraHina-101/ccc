# MeshEdit.DeleteNode()

MeshEdit.DeleteNode()

Description​

Delete floating nodes in db

Syntax​

MeshEdit.DeleteNode(crlNodes=[], bRemoveVertex=True)

Ribbon: MeshEdit » DeleteNode

Inputs​

crlNodes​

A List of Cursor specifying the node.

The default value is [].

bRemoveVertex​

A Boolean specifying the remove vertex.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.DeleteNode(crlNodes=[], bRemoveVertex=True)
