# MeshCleanup.Manual2D.CreateElement()

MeshCleanup.Manual2D.CreateElement()

Description​

Create element

Syntax​

MeshCleanup.Manual2D.CreateElement(iElemType=0, crParentEntity=None, crlNodes=[])

Ribbon: MeshCleanup » Manual2D » CreateElement

Inputs​

iElemType​

An Integer specifying the element type.

The default value is 0.

crParentEntity​

A Cursor specifying the parent entity.

The default value is None.

crlNodes​

A List of Cursor specifying the node.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Manual2D.CreateElement(iElemType=0, crParentEntity=None, crlNodes=[])
