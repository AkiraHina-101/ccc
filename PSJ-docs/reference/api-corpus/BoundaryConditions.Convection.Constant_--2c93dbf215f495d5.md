# BoundaryConditions.Convection.Constant()

BoundaryConditions.Convection.Constant()

Description​

Create natural convection condition on selected face, element or group. User inputs external temperature and convection coefficient in scalar or in a table format, then it will return convection load to the specified location.

Syntax​

BoundaryConditions.Convection.Constant(...)

Ribbon: Boundary Conditions » Convection » Constant

Inputs​

strName​

A String specifying the name of convection setting.

The default value is "Convection_1".

dExternalTemp​

A Double specifying the external temperature (default unit: Kelvin).

This is a required input.

crTableTimeTemp​

A Cursor specifying the table of dependency between time and external temperature. This table can be created using BoundaryConditions.FieldData.

The default value is None.

dConvectionCoef​

A Double specifying the convection coefficient (default unit: W/m^2*K).

This is a required input.

crTableTimeCoeff​

A Cursor specifying the table of dependency between time and convection coefficient. This table can be created using BoundaryConditions.FieldData.

The default value is None.

crTableTempCoeff​

A Cursor specifying the table of dependency between temperature and convection coefficient. This table can be created using BoundaryConditions.FieldData.

The default value is None.

crlTargets​

A List of Cursor specifying the list of targets for convection boundary condition. Target can be faces, elements or groups.

This is a required input.

crEdit​

A Cursor specifying an existing convection setting (constant).
If this parameter is used, the specified convection setting (constant) will be modified.

If it is left None, a new convection setting (constant) will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.Convection.Constant(strName="Convection_26",
                                                     dExternalTemp=373.15, 
                                                     dConvectionCoef=1E-3, 
                                                     crlTargets=[Face(26)])

JPT.Debugger(created_bcs)
