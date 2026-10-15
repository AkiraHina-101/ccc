# Geometry.DeleteEntity.Vertex()

Geometry.DeleteEntity.Vertex()

Description​

Delete the specified vertexes.

Syntax​

Geometry.DeleteEntity.Vertex(...)

Ribbon: Geometry » Delete Entity » Vertex

Inputs​

crlVertices​

A List of Cursor specifying the vertexes to be deleted.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

Geometry.BreakEntity.Edge(crlEdges=[Edge(18)],
                          crlNodes=[Node(85)])

deleting_status = Geometry.DeleteEntity.Vertex(crlVertices=[Vertex(27)])

JPT.Debugger(deleting_status)
