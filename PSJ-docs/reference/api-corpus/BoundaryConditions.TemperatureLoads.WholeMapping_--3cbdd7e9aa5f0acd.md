# BoundaryConditions.TemperatureLoads.WholeMapping()

BoundaryConditions.TemperatureLoads.WholeMapping()

Description​

Create mapping pressure.

Syntax​

BoundaryConditions.TemperatureLoads.WholeMapping(...)

Ribbon: BoundaryConditions » TemperatureLoads » WholeMapping

Inputs​

strName​

A String specifying the name.

The default value is "TemperatureLoadsWholeMapping".

crlTargets​

A List of Cursor specifying the target.

The default value is [].

iMAPPos​

An Integer specifying the m a p position.

The default value is 0.

iViewCp​

An Integer specifying the view component.

The default value is 0.

iCp​

An Integer specifying the component.

The default value is 1.

iSrcType​

An Integer specifying the source type.

The default value is 0.

iMappedCpIndexArr0​

An Integer specifying the mapped component index arr0.

The default value is 0.

iMappedCpIndexArr1​

An Integer specifying the mapped component index arr1.

The default value is 0.

iDScaleFactor​

An Integer specifying the d scale factor.

The default value is 1.

posOffset​

A Position specifying the offset.

The default value is [0,0,0].

posRotate​

A Position specifying the rotate.

The default value is [0,0,0].

dCorScale​

A Double specifying the cor scale.

The default value is 1.

dSearchRange​

A Double specifying the search range.

The default value is 0.

strPath​

A String specifying the path.

The default value is "".

crEdit​

A Cursor specifying the edit.

The default value is None.

iMappingMethod​

An Integer specifying the mapping method.

The default value is 0.

iSubmodelBCMappingType​

An Integer specifying the submodel c mapping type.

The default value is 2.

iMappingFromStepNo​

An Integer specifying the mapping from step no.

The default value is 0.

bSetADVCFile​

A Boolean specifying the set ADVC file.

The default value is False.

strADVCResultFile​

A String specifying the ADVC result file.

The default value is "".

bSetDetATol​

A Boolean specifying the set det a tolerance.

The default value is False.

dDetATol​

A Double specifying the det a tolerance.

The default value is DFLT_DBL.

bSetElementSet​

A Boolean specifying the set element set.

The default value is False.

strElementSet​

A String specifying the element set.

The default value is "".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.TemperatureLoads.WholeMapping(strName="TemperatureLoadsWholeMapping", crlTargets=[], iMAPPos=0, iViewCp=0, iCp=1, iSrcType=0, iMappedCpIndexArr0=0, iMappedCpIndexArr1=0, iDScaleFactor=1, posOffset=[0,0,0], posRotate=[0,0,0], dCorScale=1, dSearchRange=0, strPath="", crEdit=None, iMappingMethod=0, iSubmodelBCMappingType=2, iMappingFromStepNo=0, bSetADVCFile=False, strADVCResultFile="", bSetDetATol=False, dDetATol=DFLT_DBL, bSetElementSet=False, strElementSet="")
