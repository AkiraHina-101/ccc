# Designer.LBC.TemperatureLoad()

Designer.LBC.TemperatureLoad()

Description​

Create temperature load Desiner

Syntax​

Designer.LBC.TemperatureLoad(strName="", iDnType=0, dFTemp=0, strDstrFilePathName="", crDcrTable=None, crlTargets=[], crEdit=None, bDbUseAsMaterialReferenceTemp=False)

Ribbon: Designer » LBC » TemperatureLoad

Inputs​

strName​

A String specifying the name.

The default value is "".

iDnType​

An Integer specifying the dn type.

The default value is 0.

dFTemp​

A Double specifying the temperature.

The default value is 0.

strDstrFilePathName​

A String specifying the dstr file path name.

The default value is "".

crDcrTable​

A Cursor specifying the dcr table.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

bDbUseAsMaterialReferenceTemp​

A Boolean specifying the db use as material reference temperature.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Designer.LBC.TemperatureLoad(strName="", iDnType=0, dFTemp=0, strDstrFilePathName="", crDcrTable=None, crlTargets=[], crEdit=None, bDbUseAsMaterialReferenceTemp=False)
