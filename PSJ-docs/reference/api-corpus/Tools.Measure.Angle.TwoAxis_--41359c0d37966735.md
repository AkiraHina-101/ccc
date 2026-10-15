# Tools.Measure.Angle.TwoAxis()

Tools.Measure.Angle.TwoAxis()

Description​

Measure the angle created by 2 Axis.

Syntax​

Tools.Measure.Angle.TwoAxis(...)

Ribbon: Tools » Measure » Angle » TwoAxis

Inputs​

dlXyz1​

A Double List specifying the xyz1.

The default value is [0, 0, 0].

dlXyz2​

A Double List specifying the xyz2.

The default value is [0, 0, 0].

strTarget​

A String specifying the target.

The default value is "Angle".

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(7, 8, 5)])
Tools.Coordinates.ThreeNode(strName="CRect2", crlNodes=[Node(3, 7, 2)])
Tools.Measure.Angle.TwoAxis(dlXyz1=[0.0, -1.0, 0.0], dlXyz2=[1.0, 0.0, 0.0])
