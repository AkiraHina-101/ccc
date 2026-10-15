# BoundaryConditions.BoundaryTemperature.SurfaceMapping()

BoundaryConditions.BoundaryTemperature.SurfaceMapping()

Description​

Create surface mapping boundary temperature.

Syntax​

BoundaryConditions.BoundaryTemperature.SurfaceMapping(...)

Ribbon: BoundaryConditions » BoundaryTemperature » SurfaceMapping

Inputs​

strName​

A String specifying the mapping temperature name.

The default value is "MappingTemperature".

crlTargets​

A List of Cursor specifying the targets.

The default value is [].

iMAPPos​

An Integer specifying the map position.
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

The default value is 1.

iSrcType​

An Integer specifying the source type of the fluid analysis solver from which the result file was output.
0: Fluent.

1: Star CD.

2: Convection Text.

3: SZText.

4: ADVC.

5: SubmodelBC ADVC.

The default value is 0.

iMappedCpIndexArr0​

An Integer specifying the mapped component index arr0.

The default value is 0.

iMappedCpIndexArr1​

An Integer specifying the mapped component index arr1.

The default value is 0.

dScaleFactor​

A Double specifying the scale factor.

The default value is 1.0.

posOffset​

A Position specifying the offset.

The default value is [0,0,0].

posRotate​

A Position specifying the rotate.

The default value is [0,0,0].

dCorScale​

A Double specifying the coordinate scale.

The default value is 1.0.

dSearchRange​

A Double specifying the search range.

The default value is 0.0.

iUnit​

An Integer specifying the unit.
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

iMappingMethod​

An Integer specifying the mapping method.
0: Mapping Nearest.

1: Mapping CMLS.

The default value is 0.

iSubmodeLBCMappingType​

An Integer specifying the submode load boundary condition mapping type.
0: Mapping type FORCED DISPLACEMENT.

1: Mapping type LOAD FORCE.

2: Mapping type EMPERATURE.

3: Mapping type FORCED TEMPERATURE.

4: Mapping type HEAT FLUX.

The default value is 3.

iMappingFromStepNo​

An Integer specifying the mapping from step number.

The default value is 0.

bSetADVCFile​

A Boolean specifying whether set ADVC file.

The default value is False.

strADVCResultFile​

A String specifying the ADVC result file.

The default value is "".

bSetDetATol​

A Boolean specifying whether set det a tolerance.

The default value is False.

dDetATol​

A Double specifying the det a tolerance.

The default value is DFLT_DBL.

bSetElementSet​

A Boolean specifying whether set element set.

The default value is False.

strElementSet​

A String specifying the element set.

The default value is "all".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

result = BoundaryConditions.BoundaryTemperature.SurfaceMapping(strName="MappingTemperature",
    crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr0=0,
    iMappedCpIndexArr1=0, dScaleFactor=1.0, posOffset=[0,0,0], posRotate=[0,0,0], dCorScale=1.0,
    dSearchRange=0.0, iUnit=0, strPath="", crEdit=None, iMappingMethod=0, iSubmodeLBCMappingType=3,
    iMappingFromStepNo=0, bSetADVCFile=False, strADVCResultFile="", bSetDetATol=False,
    dDetATol=DFLT_DBL, bSetElementSet=False, strElementSet="all")

print(result) #for checking return value
