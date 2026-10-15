# BoundaryConditions.TemperatureLoads.Constant()

BoundaryConditions.TemperatureLoads.Constant()

Description​

Create temperature load constant.

Syntax​

BoundaryConditions.TemperatureLoads.Constant(...)

Ribbon: BoundaryConditions » TemperatureLoads » Constant

Inputs​

strName​

A String specifying the name.

This is a required input.

dTemperature​

A Double specifying the temperature.

The default value is 0.0.

crTable​

A Cursor specifying the table.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

bUseDefaultTemp​

A Boolean specifying the use default temperature.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.TemperatureLoads.Constant(strName, dTemperature=0.0, crTable=None, crlTargets=[], crEdit=None, bUseDefaultTemp=False)
