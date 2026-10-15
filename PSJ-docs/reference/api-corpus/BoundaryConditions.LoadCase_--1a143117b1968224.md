# BoundaryConditions.LoadCase()

BoundaryConditions.LoadCase()

Description​

Create a load case that bundles loads and constraints. Load cases can be referenced when creating analysis solver input data.

Syntax​

BoundaryConditions.LoadCase(...)

Ribbon: Boundary Conditions » LoadCase

Inputs​

strName​

A String specifying the name of the load case to be created.

The default value is "LoadCase1".

dFactor​

A Double specifying the load factor for Nastran that applies to the entire load case to be created. Used when multiplying the load by a factor.

The default value is 1.0.

crlTargets​

A List of Cursor specifying the list of all created boundary conditions.

The default value is [].

iExportId​

An Integer specifying the export identity number of load case.

The default value is 1.

dlTargetFactor​

A List of Double specifying the list factor of each boundary condition.

The default value is [].

crEdit​

A Cursor specifying an existing load case. If this parameter is used, the specified load case will be modified. If it is left None, a new load case will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

BoundaryConditions.Pressure.General(dPressure=1000000.0, 
                                    crlTargets=[Face(24)])

BoundaryConditions.Pressure.General(strName="Pressure2", 
                                    dPressure=2000000.0,
                                    crlTargets=[Face(21)])

BoundaryConditions.Pressure.General(strName="Pressure3", 
                                    dPressure=3000000.0,
                                    crlTargets=[Face(25)])

created_bcs = BoundaryConditions.LoadCase(crlTargets=[LbcGPressure(1, 2, 3)], 
                                          iExportId=4,
                                          dlTargetFactor=[1.0, 1.0, 1.0])

JPT.Debugger(created_bcs)
