# Analysis.AbaqusStep.StaticRiskStep()

Analysis.AbaqusStep.StaticRiskStep()

Description​

Abaqus Static Risk Step

Syntax​

Analysis.AbaqusStep.StaticRiskStep(...)

Ribbon: Analysis » AbaqusStep » StaticRiskStep

Inputs​

strName​

A String specifying the name.

This is a required input.

strDesp​

A String specifying the description.

The default value is "".

iEnableAutomatic​

An Integer specifying the enable automatic.

The default value is 0.

iMaxInc​

An Integer specifying the maximum increment.

The default value is 100.

dInitSize​

A Double specifying the initial size.

The default value is 1.0.

dMinSize​

A Double specifying the minimum size.

The default value is 1.0e-5.

dMaxSize​

A Double specifying the maximum size.

The default value is 1.0.

iMethod​

An Integer specifying the method.

The default value is 0.

iMatrixStorage​

An Integer specifying the matrix storage.

The default value is 0.

dMaxLdPropFactor​

A Double specifying the maximum ld property factor.

The default value is 0.0.

iEnableMaxLdPropFactor​

An Integer specifying the enable maximum ld property factor.

The default value is 0.

iEnableMaxDisp​

An Integer specifying the enable maximum displacement.

The default value is 0.

dMaxDisp​

A Double specifying the maximum displacement.

The default value is DFLT_DBL.

iEnableMaxDispDof​

An Integer specifying the enable maximum displacement dof.

The default value is DFLT_INT.

strNdRgn​

A String specifying the nd rgn.

The default value is "".

iEnableNlgeom​

An Integer specifying the enable nlgeom.

The default value is 0.

iEnableIncludeHeatEffect​

An Integer specifying the enable include heat effect.

The default value is 0.

iConvertDscntIter​

An Integer specifying the convert destination count iterator.

The default value is 0.

dTotalArcLength​

A Double specifying the total arc length.

The default value is 1.0.

iExtrapolateMethod​

An Integer specifying the extrapolate method.

The default value is 0.

iEnableAcceptByMaxIters​

An Integer specifying the enable accept by maximum iterators.

The default value is 0.

iEnableLongTerm​

An Integer specifying the enable long term.

The default value is 0.

iEnablePerturbation​

An Integer specifying the enable perturbation.

The default value is 0.

iFullplasticregionBchecked​

An Integer specifying the fullplasticregion check.

The default value is 0.

strlFullplasticregionTlist​

A List of String specifying the fullplasticregion table list.

The default value is [].

iOutput​

An Integer specifying the output.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.AbaqusStep.StaticRiskStep(strName, strDesp="", iEnableAutomatic=0, iMaxInc=100, dInitSize=1.0,
    dMinSize=1.0e-5, dMaxSize=1.0, iMethod=0, iMatrixStorage=0, dMaxLdPropFactor=0.0, iEnableMaxLdPropFactor=0,
    iEnableMaxDisp=0, dMaxDisp=DFLT_DBL, iEnableMaxDispDof=DFLT_INT, strNdRgn="", iEnableNlgeom=0,
    iEnableIncludeHeatEffect=0, iConvertDscntIter=0, dTotalArcLength=1.0, iExtrapolateMethod=0,
    iEnableAcceptByMaxIters=0, iEnableLongTerm=0, iEnablePerturbation=0, iFullplasticregionBchecked=0,
    strlFullplasticregionTlist=[], iOutput=0, crEdit=None)
