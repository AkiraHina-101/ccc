# BoundaryConditions.InitialTemperature.NastranPunch()

BoundaryConditions.InitialTemperature.NastranPunch()

Description​

Load the temperature result output in Nastran Punch format and set as the initial temperature.

Syntax​

BoundaryConditions.InitialTemperature.NastranPunch(...)

Ribbon: BoundaryConditions » InitialTemperature » NastranPunch

Inputs​

strName​

A String specifying the initial temperature name.

The default value is "InitialTemperature1".

strFilePathName​

A String specifying the Nastran temperature result file path.

The default value is "".

bUseDefault​

A Boolean enable/disable default temperature.

The default value is False.

crlTargets​

A List of Cursor specifying list the target parts for initial temperature.

The default value is [].

crEdit​

A Cursor specifying the initial temperature item which use for editing.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
BoundaryConditions.InitialTemperature.NastranPunch(strFilePathName="C:/Desktop/test.pch",
    crlTargets=[Part(1)])
