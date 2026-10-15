# BoundaryConditions.TemperatureLoads.LbcInitialTemperature()

BoundaryConditions.TemperatureLoads.LbcInitialTemperature()

Description​

Boundary Conditions Lbc Initial Temperature.

Syntax​

BoundaryConditions.TemperatureLoads.LbcInitialTemperature(...)

Ribbon: BoundaryConditions » TemperatureLoads » LbcInitialTemperature

Inputs​

strName​

A String specifying the name.

The default value is "InitialTemperature1".

iType​

An Integer specifying the type.

The default value is 0.

dFTemp​

A Double specifying the temperature.

The default value is 0.0.

strFilePathName​

A String specifying the file path name.

The default value is "".

bUseDefault​

A Boolean specifying the use default.

The default value is False.

crTable​

A Cursor specifying the table.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.TemperatureLoads.LbcInitialTemperature(strName="InitialTemperature1", iType=0, dFTemp=0.0, strFilePathName="", bUseDefault=False, crTable=None, crlTargets=[], crEdit=None)
