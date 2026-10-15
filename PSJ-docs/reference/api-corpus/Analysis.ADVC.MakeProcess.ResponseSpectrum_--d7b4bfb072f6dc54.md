# Analysis.ADVC.MakeProcess.ResponseSpectrum()

Analysis.ADVC.MakeProcess.ResponseSpectrum()

Description​

Create advc response spectrum process.

Syntax​

Analysis.ADVC.MakeProcess.ResponseSpectrum(...)

Macro: AdvcSpectrumProcess

Ribbon: Analysis » ADVC » MakeProcess » ResponseSpectrum

Inputs​

strName​

A String specifying the name.

The default value is "".

strRefEigenDir​

A String specifying the reference eigen direction.

The default value is "".

dRefLowFreq​

A Double specifying the reference low frequence.

The default value is DFLT_DBL.

dRefHighFreq​

A Double specifying the reference high frequence.

The default value is DFLT_DBL.

iPropMethod​

An Integer specifying the property method.

The default value is 0.

iSpttype​

An Integer specifying the spectrum type.

The default value is 0.

dSptFactor0​

A Double specifying the spectrum factor0.

The default value is DFLT_DBL.

crSpt0​

A Cursor specifying the spt0.

The default value is None.

dSptFactor1​

A Double specifying the spectrum factor1.

The default value is DFLT_DBL.

crSpt1​

A Cursor specifying the spectrum 1.

The default value is None.

dSptFactor2​

A Double specifying the spectrum factor2.

The default value is DFLT_DBL.

crSpt2​

A Cursor specifying the spectrum 2.

The default value is None.

crEdit​

A Cursor specifying the edit.

The default value is None.

listLoadNode​

A LOAD_NODE List specifying the load node.

The default value is [].

listLoadCaseNode​

A LOAD_CASE_NODE List specifying the load case node.

The default value is [].

listLoadNodeContact​

A LOAD_NODE_CONTACT List specifying the load node contact.

The default value is [].

ilOutputParamList​

A List of Integer specifying the output param list.

The default value is [].

iRefType​

An Integer specifying the reference type.

The default value is 0.

strRefPath​

A String specifying the reference path.

The default value is "".

listAdvcRefStressResult​

A ADVC_REF_STRESS_RESULT List specifying the advc reference stress result.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.ADVC.MakeProcess.ResponseSpectrum(strName="", strRefEigenDir="", dRefLowFreq=DFLT_DBL, dRefHighFreq=DFLT_DBL, iPropMethod=0, iSpttype=0, dSptFactor0=DFLT_DBL, crSpt0=None, dSptFactor1=DFLT_DBL, crSpt1=None, dSptFactor2=DFLT_DBL, crSpt2=None, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=0, strRefPath="", listAdvcRefStressResult=[])
