# BoundaryConditions.TemperatureLoads.NastranPunch()

BoundaryConditions.TemperatureLoads.NastranPunch()

Description​

Create temperature load by using Nastran punch.

Syntax​

BoundaryConditions.TemperatureLoads.NastranPunch(...)

Ribbon: BoundaryConditions » TemperatureLoads » NastranPunch

Inputs​

strName​

A String specifying the name.

The default value is "TemperatureLoadsPunch1".

strFilePathName​

A String specifying the file path name.

The default value is "".

crTable​

A Cursor specifying the table.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

bUseAsMaterialReferenceTemp​

A Boolean specifying the use as material reference temperature.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.TemperatureLoads.NastranPunch(strName="TemperatureLoadsPunch1", strFilePathName="", crTable=None, crlTargets=[], crEdit=None, bUseAsMaterialReferenceTemp=False)
