# BoundaryConditions.BoundaryTemperature.Constant()

BoundaryConditions.BoundaryTemperature.Constant()

Description​

Create a constant temperature load to part, face, edge or node. User inputs temperature in scalar or in a table format, then it will return temperature load to the specified location.

Syntax​

BoundaryConditions.BoundaryTemperature.Constant(...)

Ribbon: Boundary Conditions » Boundary Temperature » Constant

Inputs​

strName​

A String specifying name of the temperature load condition.

The default value is "BoundaryTemperature_1".

dFTemp​

A Double specifying the constant temperature value.

This is a required input.

crTable​

A Cursor specifying the table entered in the field data.

The default value is None.

crlTargets​

A List of Cursor specifying the list of targets. Target can be face, edge or node.

This is a required input.

crEdit​

A Cursor specifying an existing temperature load. If this parameter is used, the specified temperature load will be modified. If it is left None, a new temperature load will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.BoundaryTemperature.Constant(strName="BoundaryTemperature_21",
                                                              dFTemp=373.15, 
                                                              crlTargets=[Face(21)])

JPT.Debugger(created_bcs)
