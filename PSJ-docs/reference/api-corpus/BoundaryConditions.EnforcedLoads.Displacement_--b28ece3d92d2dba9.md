# BoundaryConditions.EnforcedLoads.Displacement()

BoundaryConditions.EnforcedLoads.Displacement()

Description​

Create enforced displacement to face, edge or node. User inputs enforced displacement parameters, and it will return enforced displacement to the specified location.

Syntax​

BoundaryConditions.EnforcedLoads.Displacement(...)

Ribbon: BoundaryConditions » EnforcedLoads » Displacement

Inputs​

strName​

A String specifying the enforced displacement load name.

The default value is "EnforcedDisplacement1".

iDof​

An Integer specifying the degree of freedom (DoF). This value is calculated by using OR operator between the following options.

dDispUx​

A Double specifying the enforced displacement in X translation direction (default unit: m).

The default value is DFLT_DBL.

dDispUy​

A Double specifying the enforced displacement in Y translation direction (default unit: m).

The default value is DFLT_DBL.

dDispUz​

A Double specifying the enforced displacement in Z translation direction (default unit: m).

The default value is DFLT_DBL.

dDispRx​

A Double specifying the enforced displacement in X rotation direction (default unit: rad).

The default value is DFLT_DBL.

dDispRy​

A Double specifying the enforced displacement in Y rotation direction (default unit: rad).

The default value is DFLT_DBL.

dDispRz​

A Double specifying the enforced displacement in Z rotation direction (default unit: rad).

The default value is DFLT_DBL.

crCoord​

A Cursor specifying the coordinate from which the enforced displacement is created.

The default value is None (global coordinate).

iArrowDir​

An Integer specifying how arrow direction is displayed. This parameter only affects the display of the load setting, the load itself remains intact. The value for this parameter is one of the following:

0: Start at node.

1: End at node.

The default value is 0.

crTable​

A Cursor specifying the table created from BoundaryConditions.FieldData function.

The default value is None.

crNodeSet​

A Cursor specifying the node set table created from BoundaryConditions.FieldData function.

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

crlTargets​

A List of Cursor specifying the list of targets to apply enforced displacement. Target can be face, edge or node.

This is a required input.

crEdit​

A Cursor specifying an existing enforced displacement.

If this parameter is used, the specified enforced displacement will be modified.

If it is left None, a new enforced displacement will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.EnforcedLoads.Displacement(strName="EnforcedDisplacement1", 
                                                            iDof=9,
                                                            dDispUx=0.001, 
                                                            dDispRx=1.0, 
                                                            dPhase=0.0, 
                                                            dDelay=0.0, 
                                                            crlTargets=[Face(25)])

JPT.Debugger(created_bcs)
