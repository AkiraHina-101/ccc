# BoundaryConditions.EnforcedLoads.Acceleration()

BoundaryConditions.EnforcedLoads.Acceleration()

Description​

Create enforced acceleration to face, edge or node. User inputs enforced acceleration parameters, and it will return enforced acceleration to the specified location.

Syntax​

BoundaryConditions.EnforcedLoads.Acceleration(...)

Ribbon: BoundaryConditions » EnforcedLoads » Acceleration

Inputs​

strName​

A String specifying the name of the enforced acceleration load name.

The default value is "EnforcedAcceleration1".

dAccelUx​

A Double specifying the enforced acceleration value of X translation direction.

The default value is DFLT_DBL.

dAccelUy​

A Double specifying the enforced acceleration value of Y translation direction.

The default value is DFLT_DBL.

dAccelUz​

A Double specifying the enforced acceleration value of Z translation direction.

The default value is DFLT_DBL.

dAccelRx​

A Double specifying the enforced acceleration value of X rotation direction.

The default value is DFLT_DBL.

dAccelRy​

A Double specifying the enforced acceleration value of Y d rotation direction.

The default value is DFLT_DBL.

dAccelRz​

A Double specifying the enforced acceleration value of Z rotation direction.

The default value is DFLT_DBL.

crCurCoord​

A Cursor specifying the reference coordinate system of the load.

The default value is None (global coordinate).

iArrowDir​

An Integer specifying how arrow direction is displayed. This parameter only affects the display of the load setting, the load itself remains intact. The value for this parameter is one of the following:
0: Start at node.

1: End at node.

The default value is 0.

crTable​

A Cursor specifying the table created from BoundaryConditions.FieldData function.

The default value is None.

dPhase​

A Double specifying the phase value.

The default value is DFLT_DBL.

dDelay​

A Double specifying the delay value.

The default value is DFLT_DBL.

crPhaseTable​

A Cursor specifying the phase table created from BoundaryConditions.FieldData function.

The default value is None.

bExport​

A Boolean specifying whether enable or disable the Multi-Excitation Load Export.

The default value is False.

crMEExportUx​

A Cursor specifying the table of Plural point input for X translation direction.

The default value is None.

crMEExportUy​

A Cursor specifying the table of Plural point input for Y translation direction.

The default value is None.

crMEExportUz​

A Cursor specifying the table of Plural point input for Z translation direction.

The default value is None.

crMEExportRx​

A Cursor specifying the table of Plural point input for X rotation direction.

The default value is None.

crMEExportRy​

A Cursor specifying the table of Plural point input for Y rotation direction.

The default value is None.

crMEExportRz​

A Cursor specifying the table of Plural point input for Z rotation direction.

The default value is None.

iAccelTransUnit​

An Integer specifying the input unit system for the enforced acceleration of translation.

The default value is 0.

iAccelRotUnit​

An Integer specifying the input unit system for the enforced acceleration of rotation.

The default value is 0.

crlTargets​

A List of Cursor specifying the list of targets to apply enforced acceleration. Target can be face, edge or node.

This is a required input.

crEdit​

A Cursor specifying an existing enforced acceleration.
If this parameter is used, the specified enforced acceleration will be modified.

If it is left None, a new enforced acceleration will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.EnforcedLoads.Acceleration(dAccelUz=0.01, 
                                                            crlTargets=[Face(26)])

JPT.Debugger(created_bcs)
