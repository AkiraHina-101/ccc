# BoundaryConditions.InitialTemperature.Constant()

BoundaryConditions.InitialTemperature.Constant()

Description​

Create initial temperature with constant value,

Syntax​

BoundaryConditions.InitialTemperature.Constant(...)

Ribbon: BoundaryConditions » InitialTemperature » Constant

Inputs​

strName​

A String specifying the initial temperature name.

The default value is "InitialTemperature1".

dFTemp​

A double specifying the constant temperature.

The default value is 0.0.

bUseDefault​

A Boolean enable/disable default temperature.

The default value is False.

crlTargets​

A List of Cursor specifying list of target parts for initial temperature.

The default value is [].

crEdit​

A Cursor specifying the initial temperature item which use for editing.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
BoundaryConditions.InitialTemperature.Constant(strName="InitialTemperature4",
    dFTemp=278.15, bUseDefault=True, crlTargets=[Part(1)])
