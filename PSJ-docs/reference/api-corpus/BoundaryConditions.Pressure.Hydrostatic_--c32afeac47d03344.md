# BoundaryConditions.Pressure.Hydrostatic()

BoundaryConditions.Pressure.Hydrostatic()

Description​

Create hydrostatic pressure.

Syntax​

BoundaryConditions.Pressure.Hydrostatic(...)

Ribbon: BoundaryConditions » Pressure » Hydrostatic

Inputs​

strName​

A String specifying the name.

The default value is "PressureHydrostatic1".

dFHPressure​

A Double specifying the h pressure.

The default value is 0.0.

dFDensity​

A Double specifying the density.

The default value is 0.0.

iDensityUnit​

An Integer specifying the density unit.

The default value is 0.

dFGravity​

A Double specifying the gravity.

The default value is 0.0.

iGravityUnit​

An Integer specifying the gravity unit.

The default value is 0.

iGravityDir​

An Integer specifying the gravity direction.

The default value is 0.

dFWaterSuface​

A Double specifying the water suface.

The default value is 0.0.

iSufaceUnit​

An Integer specifying the suface unit.

The default value is 0.

iDistributionMethod​

An Integer specifying the distribution method.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.Hydrostatic(strName="PressureHydrostatic1", dFHPressure=0.0, dFDensity=0.0, iDensityUnit=0, dFGravity=0.0, iGravityUnit=0, iGravityDir=0, dFWaterSuface=0.0, iSufaceUnit=0, iDistributionMethod=0, crlTargets=[], crEdit=None)
