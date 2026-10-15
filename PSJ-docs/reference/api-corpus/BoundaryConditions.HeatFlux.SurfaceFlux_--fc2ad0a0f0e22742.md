# BoundaryConditions.HeatFlux.SurfaceFlux()

BoundaryConditions.HeatFlux.SurfaceFlux()

Description​

Create a surface flux.

Syntax​

BoundaryConditions.HeatFlux.SurfaceFlux(...)

Ribbon: BoundaryConditions » HeatFlux » SurfaceFlux

Inputs​

strName​

A String specifying the name.

This is a required input.

dFflux​

A Double specifying the fflux.

This is a required input.

iDistributionMethod​

An Integer specifying the distribution method.

This is a required input.

crTable​

A Cursor specifying the table.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.HeatFlux.SurfaceFlux(strName, dFflux, iDistributionMethod, crTable, crlTargets, crEdit=None)
