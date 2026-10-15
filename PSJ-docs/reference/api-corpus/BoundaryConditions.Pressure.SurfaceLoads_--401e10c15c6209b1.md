# BoundaryConditions.Pressure.SurfaceLoads()

BoundaryConditions.Pressure.SurfaceLoads()

Description​

Create distrubited pressure.

Syntax​

BoundaryConditions.Pressure.SurfaceLoads(...)

Ribbon: BoundaryConditions » Pressure » SurfaceLoads

Inputs​

strName​

A String specifying the name.

The default value is "SurfaceLoads1".

dlPressure​

A Double List specifying the pressure.

The default value is [0,0,0].

iArrowDir​

An Integer specifying the arrow direction.

The default value is 0.

crCoordinate​

A Cursor specifying the coordinate.

The default value is None.

crlTargetsFace​

A List of Cursor specifying the target face.

The default value is [].

crEditCur​

A Cursor specifying the edit cur.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.SurfaceLoads(strName="SurfaceLoads1", dlPressure=[0,0,0], iArrowDir=0, crCoordinate=None, crlTargetsFace=[], crEditCur=None)
