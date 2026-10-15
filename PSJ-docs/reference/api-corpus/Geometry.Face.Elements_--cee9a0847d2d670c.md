# Geometry.Face.Elements()

Geometry.Face.Elements()

Description​

Create faces from the selected elements.

Syntax​

Geometry.Face.Elements(...)

Macro: CreateFaceByElem

Ribbon: Geometry » Face » Elements

Inputs​

crlElems​

A List of Cursor specifying the surface elements to be moved to the new surface.

This is a required input.

bSharedFace​

A Boolean whether to create a shared face. If bSharedFace=True, the crlElems argument must specify shared elements.

The default value is False.

Return Code​

A List of Cursor specifying the new created faces.

Sample Code​

Geometry.Part.Cube()

created_face = Geometry.Face.Elements(crlElems=[Elem(1008,
                                                    1007,
                                                    989,
                                                    990,
                                                    1005,
                                                    1006,
                                                    988,
                                                    987)])

JPT.Debugger(created_face)
