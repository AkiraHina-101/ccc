# BoundaryConditions.TemperatureLoads.ADVCFile()

BoundaryConditions.TemperatureLoads.ADVCFile()

Description​

Create temperature load by using ADVC file.

Syntax​

BoundaryConditions.TemperatureLoads.ADVCFile(...)

Ribbon: BoundaryConditions » TemperatureLoads » ADVCFile

Inputs​

strName​

A String specifying the name.

The default value is "TemperatureLoadsADVC1".

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

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.TemperatureLoads.ADVCFile(strName="TemperatureLoadsADVC1", strFilePathName="", crTable=None, crlTargets=[], crEdit=None)
