# Geometry.ShowAdjacent.Elements()

Geometry.ShowAdjacent.Elements()

Description​

Expand the selection in all directions, regardless of the shape of surrounding features or the angle at which objects are joined.
It obtained by recursively finding adjacent elements at an angle of less than or equal to the specified angle.

Syntax​

Geometry.ShowAdjacent.Elements(...)

Ribbon: Geometry » Show Adjacent » Elements

Inputs​

dAngle​

A Double specifying the angle between elements in degree. The adjacent elements that are at an angle of less than or equal to dAngle will be selected.

The default value is 0.0.

bIncludeStopElems​

A Boolean specifying whether to add the stop elements to the selection list or not.

The default value is False.

iNumOfLayers​

An Integer specifying the number of adjacent layers to be searched.

The default value is 1.

crlStartElems​

A List of Cursor specifying a sequence of the start elements.

The default value is [].

crlStopElems​

A List of Cursor specifying a sequence of the stop elements.

The default value is [].

Return Code​

A List of Cursor specifying a sequence of adjacent elements.

Sample Code​

Geometry.Part.Cube()
adjacent_elements = Geometry.ShowAdjacent.Elements(dAngle=5.0, crlStartElems=[Elem(1005)])
JPT.Debugger(adjacent_elements)
