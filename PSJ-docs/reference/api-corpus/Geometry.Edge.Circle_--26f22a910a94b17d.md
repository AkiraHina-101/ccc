# Geometry.Edge.Circle()

Geometry.Edge.Circle()

Description​

This method imprints circle lines onto the given face.

Syntax​

Geometry.Edge.Circle(veclPositions, crlTargetsFace, dInRadius=1, dOutRadius=4, iNoOfLayer=1,
    iNoOfDiv=30, bBreakFace=True)

Macro: ImprintCircleS

Ribbon: Geometry » Edge » Circle

Inputs​

veclPositions​

A List of Vector specifying points on faces where the circle will be imprinted.

This is a required input.

crlTargetsFace​

A List of Cursor specifying faces to be imprinted.

This is a required input.

dInRadius​

A Double specifying inner circle's radius. This argument is to be used when the iNoOfLayer argument has a value greater than 1. Possible values are 0.0 ≤ dInRadius ≤ dOutRadius.

The default value is 1.

dOutRadius​

A Double specifying outer circle's radius.

The default value is 4.

iNoOfLayer​

An Integer specifying number of layers to be imprinted from circle center.

The default value is 1.

iNoOfDiv​

An Integer specifying the number of segments in which the circle will be divided equally.

The default value is 30.

bBreakFace​

A Boolean specifying whether to break the given faces where possible after imprint operation.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Edge.Circle(veclPositions=[[0.006666666666666666, 0.005555555555555556, 0.01],
    [0.002222222222222222, 0.006666666666666666, 0.01]], crlTargetsFace=[Face(26)], dOutRadius=2.0)
