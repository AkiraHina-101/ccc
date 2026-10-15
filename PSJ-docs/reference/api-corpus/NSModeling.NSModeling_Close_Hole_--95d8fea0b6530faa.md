# NSModeling.NSModeling_Close_Hole()

NSModeling.NSModeling_Close_Hole()

Description​

NSModeling NSModeling_Close_Hole

Syntax​

NSModeling.NSModeling_Close_Hole(iType, dMaxLength, bMergeFaces, bSetCenterPoint, crlNodes, crlParts)

Ribbon: NSModeling » NSModeling_Close_Hole

Inputs​

iType​

An Integer specifying the type.

This is a required input.

dMaxLength​

A Double specifying the maximum length.

This is a required input.

bMergeFaces​

A Boolean specifying the merge faces.

This is a required input.

bSetCenterPoint​

A Boolean specifying the set center point.

This is a required input.

crlNodes​

A List of Cursor specifying the node.

This is a required input.

crlParts​

A List of Cursor specifying the part.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

NSModeling.NSModeling_Close_Hole(iType, dMaxLength, bMergeFaces, bSetCenterPoint, crlNodes, crlParts)
