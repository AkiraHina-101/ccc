# Tools.Measure.Radius.ThreeNodes()

Tools.Measure.Radius.ThreeNodes()

Description​

Measure arc radius by using 3 nodes.

Syntax​

Tools.Measure.Radius.ThreeNodes(...)

Ribbon: Tools » Measure » Radius » ThreeNodes

Inputs​

crNode13​

A Cursor specifying the first node on the arc whose radius is measured.

This is a required input.

crNode23​

A Cursor specifying the second node on the arc whose radius is measured.

This is a required input.

crNode33​

A Cursor specifying the third node on the arc whose radius is measured.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of arc radius can be measured.

The default value is 6.

Return Code​

A Double specifying the arc radius value.

Sample Code​

Geometry.Part.Cylinder()

radius = Tools.Measure.Radius.ThreeNodes(crNode13=Node(18), 
                                         crNode23=Node(14), 
                                         crNode33=Node(8))

JPT.Debugger(radius)
