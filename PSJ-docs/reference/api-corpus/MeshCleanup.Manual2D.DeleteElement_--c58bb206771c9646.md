# MeshCleanup.Manual2D.DeleteElement()

MeshCleanup.Manual2D.DeleteElement()

Description​

Delete Element

Syntax​

MeshCleanup.Manual2D.DeleteElement(crlElems, bKeepShareElem=False)

Ribbon: MeshCleanup » Manual2D » DeleteElement

Inputs​

crlElems​

A List of Cursor specifying the element.

This is a required input.

bKeepShareElem​

A Boolean specifying the keep share element.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Manual2D.DeleteElement(crlElems, bKeepShareElem=False)
