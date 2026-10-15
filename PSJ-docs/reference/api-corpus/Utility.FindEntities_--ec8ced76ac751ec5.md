# Utility.FindEntities()

Utility.FindEntities()

Description​

Search entity by ID, Name ...etc

Syntax​

Utility.FindEntities(strTarget, strFindType, bFindMatch=False)

Macro: FindEntities

Ribbon: Utility » FindEntities

Inputs​

strTarget​

A String specifying the target.

This is a required input.

strFindType​

A String specifying the find type.

This is a required input.

bFindMatch​

A Boolean specifying the find match.

The default value is False.

Return Code​

A List of Cursor of result entities found.

Sample Code​

Geometry.Part.Cube()

list_faces = Utility.FindEntities("24 26", "Face")
