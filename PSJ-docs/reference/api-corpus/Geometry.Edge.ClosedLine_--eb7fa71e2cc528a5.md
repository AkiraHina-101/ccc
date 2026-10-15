# Geometry.Edge.ClosedLine()

Geometry.Edge.ClosedLine()

Description​

This method imprints closed lines onto the given face.

Syntax​

Geometry.Edge.ClosedLine(veclPositions, crlTargetsFace, iEnableBreakFace=1)

Macro: ImprintCloseLineS

Ribbon: Geometry » Edge » Closed Line

Inputs​

veclPositions​

A List of Vector specifying points on faces to be imprinted.

This is a required input.

crlTargetsFace​

A List of Cursor specifying faces to be imprinted.

This is a required input.

iEnableBreakFace​

An Integer specifying whether to break the given faces after the imprint operation. Possible values are 0 and 1.

If iEnableBreakFace=0, do not break given face where possible after the imprint operation.

If iEnableBreakFace=1, break given face where possible after the imprint operation.

The default value is 1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Edge.ClosedLine(veclPositions=[[0.0058, 0.0028, 0.01], [0.0038, 0.0029, 0.01],
    [0.0040, 0.0047, 0.01], [0.0063, 0.0046, 0.01]], crlTargetsFace=[Face(26)])
