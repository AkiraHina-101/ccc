# BoundaryConditions.InitialTemperature.WholeMapping()

BoundaryConditions.InitialTemperature.WholeMapping()

Description​

Create initial temperature whole mapping.

Syntax​

BoundaryConditions.InitialTemperature.WholeMapping(...)

Ribbon: BoundaryConditions » InitialTemperature » WholeMapping

Inputs​

strName​

A String specifying the name.

The default value is "TemperatureInitsWholeMapping1".

iMapSourceType​

An Integer specifying the map source type.

The default value is 0.

strPath​

A String specifying the path.

The default value is "".

iMappingMethod​

An Integer specifying the mapping method.

The default value is 0.

iIsubcase​

An Integer specifying the isubcase.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.InitialTemperature.WholeMapping(strName="TemperatureInitsWholeMapping1", iMapSourceType=0, strPath="", iMappingMethod=0, iIsubcase=0, crEdit=None)
