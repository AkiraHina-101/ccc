# MeshCleanup.Element.SolidElement()

MeshCleanup.Element.SolidElement()

Description​

Change Topology for Solid Element

Syntax​

MeshCleanup.Element.SolidElement(crlElems, crPart=None)

Ribbon: MeshCleanup » Element » SolidElement

Inputs​

crlElems​

A List of Cursor specifying the element.

This is a required input.

crPart​

A Cursor specifying the part.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Element.SolidElement(crlElems, crPart=None)
