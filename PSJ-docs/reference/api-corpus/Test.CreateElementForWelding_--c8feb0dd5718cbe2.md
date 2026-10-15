# Test.CreateElementForWelding()

Test.CreateElementForWelding()

Description​

Create weld elements

Syntax​

Test.CreateElementForWelding(crlSrcElems, crlDstElems, crlSideElems, crlParts, crMaterial)

Ribbon: Test » CreateElementForWelding

Inputs​

crlSrcElems​

A List of Cursor specifying the source elems.

This is a required input.

crlDstElems​

A List of Cursor specifying the dst elems.

This is a required input.

crlSideElems​

A List of Cursor specifying the side elems.

This is a required input.

crlParts​

A List of Cursor specifying the part.

This is a required input.

crMaterial​

A Cursor specifying the material.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Test.CreateElementForWelding(crlSrcElems, crlDstElems, crlSideElems, crlParts, crMaterial)
