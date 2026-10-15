# Geometry.DeleteEntity.Face()

Geometry.DeleteEntity.Face()

Description​

Delete face entities.

Syntax​

Geometry.DeleteEntity.Face(...)

Ribbon: Geometry » Delete Entity » Face

Inputs​

crlFaces​

A List of Cursor specifying faces to be deleted.

This is a required input.

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Face(crlFaces=[Face(26)])

JPT.Debugger(flag)
