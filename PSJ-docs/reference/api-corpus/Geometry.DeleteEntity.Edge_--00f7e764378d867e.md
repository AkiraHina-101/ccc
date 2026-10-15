# Geometry.DeleteEntity.Edge()

Geometry.DeleteEntity.Edge()

Description​

Delete the selected edge entities.

Syntax​

Geometry.DeleteEntity.Edge(...)

Ribbon: Geometry » Delete Entity » Edge

Inputs​

crlEdges​

A List of Cursor specifying edges to be deleted.

This is a required input.

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Edge(crlEdges=[Edge(15, 18, 19)])

JPT.Debugger(flag)
