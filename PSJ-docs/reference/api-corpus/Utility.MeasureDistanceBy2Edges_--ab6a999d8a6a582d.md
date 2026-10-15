# Utility.MeasureDistanceBy2Edges()

Utility.MeasureDistanceBy2Edges()

Description​

Unknown Description

Syntax​

Utility.MeasureDistanceBy2Edges(crEdgeFirst, crEdgeLast, iPrecision=6)

Macro: MeasureDistanceBy2Edges

Ribbon: Utility » MeasureDistanceBy2Edges

Inputs​

crEdgeFirst​

A Cursor specifying the edge first.

This is a required input.

crEdgeLast​

A Cursor specifying the edge last.

This is a required input.

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A Double of distance between two edges.

Sample Code​

Geometry.Part.Cube()

distance = Utility.MeasureDistanceBy2Edges(crEdgeFirst=Edge(20), crEdgeLast=Edge(18))
print('Distance = ' + str(distance))
