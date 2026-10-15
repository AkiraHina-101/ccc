# Geometry.Bar.TwoNodes()

Geometry.Bar.TwoNodes()

Description​

Create a Bar part from two selected nodes.

Syntax​

Geometry.Bar.TwoNodes(...)

Macro: CreateBar

Ribbon: Geometry » Bar » 2 Nodes

Inputs​

crStartNode​

A Cursor specifying the start node.

This is a required input.

crEndNode​

A Cursor specifying the end node.

This is a required input.

strName​

A String specifying the name of new part.

The default value is "Bar_1".

iMeshOption​

An Integer specifying the option to generate element on Bar body.

If iMeshOption=0: The new Bar body has the number of 1D elements equal to iMeshCount.

If iMeshOption=1: The new Bar body has the size of 1D elements on the Bar body equal to dMeshSize.

The default value is 0.

iMeshCount​

An Integer specifying the number of 1D elements on the Bar body. This argument should be specified when iMeshOption=0.

The default value is 5.

dMeshSize​

A Double specifying the size of 1D elements on the Bar body. This argument should be specified when iMeshOption=1.

The default value is 0.0.

Return Code​

A Cursor specifying the created bar part.

Sample Code​

Geometry.Part.Cube()

newBar = Geometry.Bar.TwoNodes(crStartNode=Node(5), crEndNode=Node(7))
JPT.Debugger(newBar)
