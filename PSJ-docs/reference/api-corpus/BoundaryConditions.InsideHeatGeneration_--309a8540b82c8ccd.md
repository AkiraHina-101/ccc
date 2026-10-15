# BoundaryConditions.InsideHeatGeneration()

BoundaryConditions.InsideHeatGeneration()

Description​

Create load boundary condition of inside heat generation.

Syntax​

BoundaryConditions.InsideHeatGeneration(...)

Ribbon: BoundaryConditions » InsideHeatGeneration

Inputs​

strName​

A String specifying the name.

The default value is "InsideHeatGeneration1".

dInsideFlux​

A Double specifying the inside flux.

The default value is DFLT_DBL.

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

BoundaryConditions.InsideHeatGeneration(strName="InsideHeatGeneration1", dInsideFlux=DFLT_DBL, crTable=None, crlTargets=[], crEdit=None)
