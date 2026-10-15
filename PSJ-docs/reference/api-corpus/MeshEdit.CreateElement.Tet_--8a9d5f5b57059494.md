# MeshEdit.CreateElement.Tet()

MeshEdit.CreateElement.Tet()

Description​

Create element Tet

Syntax​

MeshEdit.CreateElement.Tet(iParentEntityId=0, crlNodes=[], crlElems=[])

Ribbon: MeshEdit » CreateElement » Tet

Inputs​

iParentEntityId​

An Integer specifying the parent entity ID.

The default value is 0.

crlNodes​

A List of Cursor specifying the node.

The default value is [].

crlElems​

A List of Cursor specifying the element.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateElement.Tet(iParentEntityId=0, crlNodes=[], crlElems=[])
