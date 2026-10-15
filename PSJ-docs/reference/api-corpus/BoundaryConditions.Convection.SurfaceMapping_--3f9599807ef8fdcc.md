# BoundaryConditions.Convection.SurfaceMapping()

BoundaryConditions.Convection.SurfaceMapping()

Description​

Create load boundary condition of convection surface mapping.

Syntax​

BoundaryConditions.Convection.SurfaceMapping(...)

Ribbon: BoundaryConditions » Convection » SurfaceMapping

Inputs​

strName​

A String specifying the Mapping Convection name.

The default value is "MappingConvection_1".

crlTargets​

A List of Cursor specifying the targets.

The default value is [].

iPos​

An Integer specifying the MAP position.
0: MAP_POS_SURFACE_NODE.

1: MAP_POS_SOLID_NODE.

2: MAP_POS_SURFACE_ELEM.

3: MAP_POS_SOLID_ELEM.

The default value is 0.

iViewCp​

An Integer specifying the component index that to be previewed.

The default value is 0.

iCp​

An Integer specifying the component.

The default value is 0.

iSrcType​

An Integer specifying the source type of the fluid analysis solver from which the result file was output.
0: Fluent.

1: Star CD.

2: CSV.

The default value is 0.

iMappedCpIndex0​

An Integer specifying the mapped component index0.

The default value is 0.

iMappedCpIndex1​

An Integer specifying the mapped component index1.

The default value is 0.

dRScale​

A Double specifying the rotation scale.

The default value is 1.0.

posOffset​

A Position specifying the offset.

The default value is [0,0,0].

posAxis​

A Position specifying the axis.

The default value is [0,0,0].

dTScale​

A Double specifying the translation scale.

The default value is 1.0.

dSearchRange​

A Double specifying the search range.

The default value is 1.0.

iHTCUnit​

An Integer specifying the HTC unit.
0: mW/mm^2.

1: W/mm^2.

2: miuW/mm^2.

3: lcal/mm^2*h.

4: lbf/ft*s.

5: lbf/in*s.

The default value is 0.

iTempUnit​

An Integer specifying the temperature unit.
0: degree Kenvil (K).

1: degree Celsius (deg C).

2: degree Fahrenheit (deg F).

The default value is 0.

strPath​

A String specifying the path.

The default value is "".

crEdit​

A Cursor specifying the cursor of boundary condition need editing.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

result = BoundaryConditions.Convection.SurfaceMapping(strName="MappingConvection_5",
    crlTargets=[], iPos=0, iViewCp=0, iCp=0, iSrcType=0, iMappedCpIndex0=0,
    iMappedCpIndex1=0, dRScale=1.0, posOffset=[0,0,0], posAxis=[0,0,0], dTScale=1.0,
    dSearchRange=1.0, iHTCUnit=0, iTempUnit=0, strPath="", crEdit=None)

print(result) #for checking return value
