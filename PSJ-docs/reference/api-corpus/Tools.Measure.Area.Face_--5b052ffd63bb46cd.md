# Tools.Measure.Area.Face()

Tools.Measure.Area.Face()

Description​

Measure an area of a face or a total area of faces.

Syntax​

Tools.Measure.Area.Face(...)

Ribbon: Tools » Measure » Area » Face

Inputs​

crlFaces​

A List of Cursor specifying the list of faces to measure area.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of Area can be measured.

The default value is 6.

Return Code​

A Double specifying the area value of a face or a total area value of faces.

Sample Code​

Geometry.Part.Cube()

area = Tools.Measure.Area.Face(crlFaces=[Face(26)])

JPT.Debugger(area)
