# Geometry.DeleteEntity.Part()

Geometry.DeleteEntity.Part()

Description​

Delete part entities.

Syntax​

Geometry.DeleteEntity.Part(...)

Ribbon: Geometry » Delete Entity » Part

Inputs​

crlParts​

A List of Cursor specifying parts to be deleted.

This is a required input.

Return Code​

True if success, or False if fail.

Sample Code​

cube = Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Part(crlParts=[cube])

JPT.Debugger(flag)
