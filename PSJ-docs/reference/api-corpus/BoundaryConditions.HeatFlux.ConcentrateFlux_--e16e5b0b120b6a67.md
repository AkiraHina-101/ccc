# BoundaryConditions.HeatFlux.ConcentrateFlux()

BoundaryConditions.HeatFlux.ConcentrateFlux()

Description​

Create a heat flux condition.

Syntax​

BoundaryConditions.HeatFlux.ConcentrateFlux(...)

Ribbon: BoundaryConditions » HeatFlux » ConcentrateFlux

Inputs​

strName​

A String specifying the name.

The default value is "ConcentrateHeatFlux1".

dflux​

A Double specifying the heat flux value.

The default value is 0.0.

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

BoundaryConditions.HeatFlux.ConcentrateFlux(strName = "ConcentrateHeatFlux1", dflux=0.0, crTable=None, crlTargets=[], crEdit=None)
