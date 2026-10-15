# Tools.Measure.Area.Element()

Tools.Measure.Area.Element()

Description​

Measure Area By Element

Syntax​

Tools.Measure.Area.Element(...)

Ribbon: Tools » Measure » Area » Element

Inputs​

crlElems​

A List of Cursor specifying the element.

The default value is [].

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

area=Tools.Measure.Area.Element(crlElems=[Elem(1025,1026)])
JPT.Debugger(area)

area=Tools.Measure.Area.Element(crlElems=[Elem(1025,1026)], iPrecision=15)
JPT.Debugger(area)
