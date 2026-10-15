# MuxWeld.CreateWeld.CreateBeadWeld()

MuxWeld.CreateWeld.CreateBeadWeld()

Description​

Unknown Description

Syntax​

MuxWeld.CreateWeld.CreateBeadWeld(crlEdges, crlPrjtedEdge, crlParts, dTol, dRatio, crRefElem)

Ribbon: MuxWeld » CreateWeld » CreateBeadWeld

Inputs​

crlEdges​

A List of Cursor specifying the edge.

This is a required input.

crlPrjtedEdge​

A List of Cursor specifying the projected edge.

This is a required input.

crlParts​

A List of Cursor specifying the part.

This is a required input.

dTol​

A Double specifying the tolerance.

This is a required input.

dRatio​

A Double specifying the ratio.

This is a required input.

crRefElem​

A Cursor specifying the reference element.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MuxWeld.CreateWeld.CreateBeadWeld(crlEdges, crlPrjtedEdge, crlParts, dTol, dRatio, crRefElem)
