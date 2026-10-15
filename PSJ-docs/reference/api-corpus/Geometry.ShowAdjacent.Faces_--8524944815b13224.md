# Geometry.ShowAdjacent.Faces()

Geometry.ShowAdjacent.Faces()

Description​

Expand the selection in all directions, regardless of the shape of surrounding features or the angle at which objects are joined.
It obtained by recursively finding adjacent faces at an angle of less than or equal to the specified angle.

Syntax​

Geometry.ShowAdjacent.Faces(...)

Ribbon: Geometry » Show Adjacent » Faces

Inputs​

dAngle​

A Double specifying the angle between elements in degree. The adjacent faces that are at an angle of less than or equal to dAngle will be selected.

The default value is 0.0.

bIncludeStopFaces​

A Boolean specifying whether to add the stop faces to the selection list or not.

The default value is False.

iNumOfLayers​

An Integer specifying the number of adjacent layers to be searched.

The default value is 1.

crlStartFaces​

A List of Cursor specifying a sequence of start faces.

The default value is [].

crlStopFaces​

A List of Cursor specifying a sequence of stop faces.

The default value is [].

Return Code​

A List of Cursor specifying a sequence of adjacent faces.

Sample Code​

Geometry.Part.Cube()
adjacent_faces = Geometry.ShowAdjacent.Faces(dAngle=0, iNumOfLayers=100, crlStartFaces=[Face(26)])
JPT.Debugger(adjacent_faces)
