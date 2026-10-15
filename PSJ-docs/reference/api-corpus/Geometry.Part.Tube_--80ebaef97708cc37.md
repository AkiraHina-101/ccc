# Geometry.Part.Tube()

Geometry.Part.Tube()

Description​

Create a tubular body around specific edge(s).

Syntax​

Geometry.Part.Tube(...)

Ribbon: Geometry » Part » Tube

Inputs​

crlEdges​

A List of Cursor specifying edges which will be the center axis of the created tube.

This is a required input.

strName​

A String specifying the name of the newly created part.

The default value is "Tube_1".

bTri​

A Boolean specifying the mesh type of newly created part.

If True, Tri3 element will be used.

If False, Quad4 element will be used.

The default value is True.

dRadius​

A Double specifying the radius of the tube.

The default value is 0.01.

dMeshSizeAxis​

A Double specifying the mesh size of the center axis.

The default value is 0.005.

dWMeshSizeCirc​

A Double specifying the mesh size of the circle at both ends (circumference).

If this parameter is used, iCircularNodes will be ignored (equal to -1).

The default value is 0.001.

iCircularNodes​

An Integer specifying the number of nodes to be generated on the circle at both ends (circumference).

If this parameter is used, dWMeshSizeCirc will be ignored (equal to -1.0).

The default value is 36.

Return Code​

A Cursor specifying the created part.

Sample Code​

Geometry.Part.Cube()

created_tube = Geometry.Part.Tube(strName="Tube_1", 
                                  crlEdges=[Edge(19)])

JPT.Debugger(created_tube)
