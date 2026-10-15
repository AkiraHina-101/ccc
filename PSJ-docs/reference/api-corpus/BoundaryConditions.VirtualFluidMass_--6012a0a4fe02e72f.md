# BoundaryConditions.VirtualFluidMass()

BoundaryConditions.VirtualFluidMass()

Description​

Create a virtual fluid mass.

Syntax​

BoundaryConditions.VirtualFluidMass(...)

Macro:

Ribbon: BoundaryConditions » VirtualFluidMass

Inputs​

crEdit​

A Cursor specifying existing virtual fluid mass.

The default value is None.

strName​

A String specifying the name.

The default value is "FluidVolume_1".

crlTargetFaces​

A List of Cursor specifying the target faces.

The default value is [].

crlTargetElems​

A List of Cursor specifying the target elements.

The default value is [].

crlTargetGroups​

A List of Cursor specifying the target groups.

The default value is [].

iWettedSideType​

An Integer specifying wetted side.

The default value is 0.

crlNegativeSideTargets​

A List of Cursor specifying negative side targets.

The default value is [].

dFluidDensity​

A Double specifying fluid density.

The default value is 0.0.

iFluidDensityUnit​

An Integer specifying unit of fluid density.

The default value is 0.

crCoordinate​

A Cursor specifying local coordinate.

The default value is None.

dFluidHeight​

A Double specifying coordinate of fluid.

The default value is 0.0.

iFluidHeightUnit​

An Integer specifying unit of coordinate of fluid.

The default value is 0.

iPlaneOfSymmetry1​

An Integer specifying planes of symmetry 1.

The default value is 2.

iPlaneOfSymmetry2​

An Integer specifying planes of symmetry 2.

The default value is 2.

Return Code​

This function does not have return value.

Sample Code​

Geometry.Part.Cube(
    ilAxialNodes=[4, 4, 4], 
    strName="Cube_2", 
    iPartColor=14903267)

Meshing.SolidMeshing(
    crlParts=[Part(1)], 
    bTet10=True, 
    dGradingFactor=1.05, 
    dStretchLimit=0.1, 
    iSpeedVsQual=1, 
    iRegion=1, 
    bSafeMode=False, 
    iParallel=16, 
    bInternalMeshOnly=False, 
    iPartColor=65280)

BoundaryConditions.VirtualFluidMass(
    crlTargetFaces=[Face(26, 24, 22, 23, 21)], 
    crlNegativeSideTargets=[Face(24, 22, 23, 21)],
    dFluidDensity=1000000000000000.0)
