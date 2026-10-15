# SZOnepushReliability.MeshEdit.FilletMapping()

SZOnepushReliability.MeshEdit.FilletMapping()

Description​

Fillet mapping

Syntax​

SZOnepushReliability.MeshEdit.FilletMapping(crlParts, crlFaces, dMinRadius, dMaxRadius, dMinAngle, dMaxAngle, bConvex, bConcave)

Ribbon: SZOnepushReliability » MeshEdit » FilletMapping

Inputs​

crlParts​

A List of Cursor specifying the part.

This is a required input.

crlFaces​

A List of Cursor specifying the face.

This is a required input.

dMinRadius​

A Double specifying the minimum radius.

This is a required input.

dMaxRadius​

A Double specifying the maximum radius.

This is a required input.

dMinAngle​

A Double specifying the minimum angle.

This is a required input.

dMaxAngle​

A Double specifying the maximum angle.

This is a required input.

bConvex​

A Boolean specifying the convex.

This is a required input.

bConcave​

A Boolean specifying the concave.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

SZOnepushReliability.MeshEdit.FilletMapping(crlParts, crlFaces, dMinRadius, dMaxRadius, dMinAngle, dMaxAngle, bConvex, bConcave)
