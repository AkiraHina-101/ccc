# BoundaryConditions.Pressure.FunctionLoadToCylinderSine()

BoundaryConditions.Pressure.FunctionLoadToCylinderSine()

Description​

Unknown Description

Syntax​

BoundaryConditions.Pressure.FunctionLoadToCylinderSine(...)

Ribbon: BoundaryConditions » Pressure » FunctionLoadToCylinderSine

Inputs​

strName​

A String specifying the name.

The default value is "PressureSine1".

dA​

A Double specifying the a.

The default value is 0.0.

crCoordinate​

A Cursor specifying the coordinate.

The default value is None.

dAngleRange​

A Double specifying the angle range.

The default value is 0.0.

bDistributionAxis​

A Boolean specifying the distribution axis.

The default value is False.

iPressureDirectionMode​

An Integer specifying the pressure direction mode.

The default value is 0.

bIsTotalForceAdjustment​

A Boolean specifying the is total force adjustment.

The default value is False.

dTotalForce​

A Double specifying the total force.

The default value is 0.0.

vecPressureDirection​

A Vector specifying the pressure direction.

The default value is [0.0,0.0,0.0].

crCoordinateSystemForDirection​

A Cursor specifying the coordinate system for direction.

The default value is None.

bIsCornerNodesDistribution​

A Boolean specifying the is corner nodes distribution.

The default value is False.

strFormulaForA​

A String specifying the formula for a.

The default value is "".

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.FunctionLoadToCylinderSine(strName="PressureSine1", dA=0.0, crCoordinate=None, dAngleRange=0.0, bDistributionAxis=False, iPressureDirectionMode=0, bIsTotalForceAdjustment=False, dTotalForce=0.0, vecPressureDirection=[0.0,0.0,0.0], crCoordinateSystemForDirection=None, bIsCornerNodesDistribution=False, strFormulaForA="", crlTargets=[], crEdit=None)
