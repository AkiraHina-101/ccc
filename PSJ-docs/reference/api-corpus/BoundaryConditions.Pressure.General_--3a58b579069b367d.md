# BoundaryConditions.Pressure.General()

BoundaryConditions.Pressure.General()

Description​

Create a general pressure applied to the selected Face, Element or Group. User inputs the pressure value and it will apply the pressure to the selected items.

Syntax​

BoundaryConditions.Pressure.General(...)

Ribbon: BoundaryConditions » Pressure » General

Inputs​

strName​

A String specifying the name of pressure condition to be created.

The default value is "Pressure1".

dPressure​

A Double specifying the pressure value applied to the selected targets.

The default value is 0.0.

iDistribute​

An Integer specifying the LBC arrow position.

0: DISTRIBUTE_PER_SELECTION

1: DISTRIBUTE_PER_NODE

2: DISTRIBUTE_TOTAL

The default value is 0.

crTable​

A Cursor specifying the table.

The default value is None.

dPhase​

A Double specifying the phase value.

The default value is 0.0.

dDelay​

A Double specifying the delay value.

The default value is 0.0.

crPhaseTable​

A Cursor specifying the phase table.

The default value is None.

strFormulaValue​

A String specifying the formula value.

The default value is "".

crCoord​

A Cursor specifying the coordinate to be used.

The default value is None.

dlDirection​

A List of Double specifying the direction.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

strFormulaDirX​

A String specifying the formula in direction X.

The default value is "".

strFormulaDirY​

A String specifying the formula in direction Y.

The default value is "".

strFormulaDirZ​

A String specifying the formula in direction Z.

The default value is "".

iArrowDir​

An Integer specifying the arrow direction.

0: Start at Node.

1: End at Node.

The default value is 1.

crlTargets​

A List of Cursor specifying the list of targets for general pressure. This targets can be Face, Element or Group.

The default value is [].

crEdit​

A Cursor specifying an existing general pressure.

If this parameter is used, the specified general pressure will be modified.

If it is left None, a new general pressure will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.Pressure.General(dPressure=10000000.0, 
                                                  crlTargets=[Face(26)])

JPT.Debugger(created_lbc)
