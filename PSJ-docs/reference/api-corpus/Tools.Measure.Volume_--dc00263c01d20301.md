# Tools.Measure.Volume()

Tools.Measure.Volume()

Description​

Measure volume of the specified parts.

Syntax​

Tools.Measure.Volume(...)

Ribbon: Tools » Measure » Volume

Inputs​

crlParts​

A List of Cursor specifying the part to measure volume.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of volume can be measured.

The default value is 6.

Return Code​

A Double specifying the volume value.

Sample Code​

Geometry.Part.Cylinder()

volume = Tools.Measure.Volume(crlParts=[Part(1)])

JPT.Debugger(volume)
