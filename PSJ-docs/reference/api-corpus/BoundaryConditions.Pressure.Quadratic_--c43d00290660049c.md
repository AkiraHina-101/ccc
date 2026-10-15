# BoundaryConditions.Pressure.Quadratic()

BoundaryConditions.Pressure.Quadratic()

Description​

Create quadratic pressure.

Syntax​

BoundaryConditions.Pressure.Quadratic(...)

Ribbon: BoundaryConditions » Pressure » Quadratic

Inputs​

strName​

A String specifying the name.

The default value is "PressureQuadratic1".

dA​

A Double specifying the a.

The default value is 0.0.

dB​

A Double specifying the .

The default value is 0.0.

crCoordinate​

A Cursor specifying the coordinate.

The default value is None.

dAngleRange​

A Double specifying the angle range.

The default value is 0.0.

iPressureDirectionMode​

An Integer specifying the pressure direction mode.

The default value is 0.

dlPressureDirection​

A Double List specifying the pressure direction.

The default value is [0.0,0.0,0.0].

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.Quadratic(strName="PressureQuadratic1", dA=0.0, dB=0.0, crCoordinate=None, dAngleRange=0.0, iPressureDirectionMode=0, dlPressureDirection=[0.0,0.0,0.0], crlTargets=[], crEdit=None)
