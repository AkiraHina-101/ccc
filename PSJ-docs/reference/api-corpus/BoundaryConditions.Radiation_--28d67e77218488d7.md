# BoundaryConditions.Radiation()

BoundaryConditions.Radiation()

Description​

Create a radiation applied to the selected Face or Element or Group. User inputs the radiation value and it will apply the radiation to the selected items

Syntax​

BoundaryConditions.Radiation(...)

Macro:

Ribbon: BoundaryConditions » Radiation

Inputs​

strName​

A String specifying name of radiation.

The default value is "Radiation".

radiation​

A LBC_RADIATION_DATA specifying radiation

The default value is LBC_RADIATION_DATA().

dAmbientTemp​

A Double specifying the value of Ambient Temperature.

This is a required input.

crTimeDependAm​

A Cursor of FieldData specifying information of Time Dependence Ambient in a table format

The default value is 0:0 (no reference).

dEmissivity​

A Double specifying the value of Emissivity.

This is a required input.

crTimeDependEm​

A Cursor of FieldData specifying information of Time Dependence Emissivity in a table format

The default value is 0:0 (no reference).

crTempDependEm​

A Cursor of FieldData specifying information of Temp Dependence Emissivity in a table format

The default value is 0:0 (no reference).

crlTargets​

A List of Cursor specifying target to set Radiation.

The default value is [].

crEdit​

A Cursor specifying existing Radiation when edit it.

The default value is None (create mode).

Return Code​

A Cursor specifying created / edited Radiation.

Sample Code​

Geometry.Part.Cube()
BoundaryConditions.Radiation(
    strName="Radiation_1", 
    radiation=LBC_RADIATION_DATA(
        dAmbientTemp=373.15, 
        crTimeDependAm=None, 
        dEmissivity=0.5, 
        crTimeDependEm=None, 
        crTempDependEm=None), 
    crlTargets=[Face(26), Elem(301, 341)])
