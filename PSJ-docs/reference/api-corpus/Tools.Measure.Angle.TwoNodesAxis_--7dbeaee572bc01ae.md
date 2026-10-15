# Tools.Measure.Angle.TwoNodesAxis()

Tools.Measure.Angle.TwoNodesAxis()

Description​

Measure the angle created by 2 nodes and Axis.

Syntax​

Tools.Measure.Angle.TwoNodesAxis(...)

Ribbon: Tools » Measure » Angle » TwoNodesAxis

Inputs​

crNode1​

A Cursor specifying the node1.

This is a required input.

crNode2​

A Cursor specifying the node2.

This is a required input.

dlAxis​

A Double List specifying the axis.

The default value is [1,0,0].

strTarget​

A String specifying the target.

The default value is "Angle".

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

Value measured with the precision set in iPrecision in String format.

Sample Code​

Geometry.Part.Cube()

angle=Tools.Measure.Angle.TwoNodesAxis(
    crNode1=Node(462), 
    crNode2=Node(466), 
    dlAxis=[0.0, 1.0, 0.0])

JPT.Debugger(angle)
