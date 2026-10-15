# Analysis.ADVC.MakeProcess.RandomResponse()

Analysis.ADVC.MakeProcess.RandomResponse()

Description​

Create ADVC random response process

Syntax​

Analysis.ADVC.MakeProcess.RandomResponse(...)

Macro: AdvcRandomProcess

Ribbon: Analysis » ADVC » MakeProcess » RandomResponse

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

crModalDampingRatio​

A Cursor specifying the modal damping ratio.

The default value is None.

crExcitationFreq​

A Cursor specifying the excitation frequence.

The default value is None.

bAutoFreqInterval​

A Boolean specifying the auto frequence interval.

The default value is False.

dMaxFreq​

A Double specifying the maximum frequence.

The default value is DFLT_DBL.

dMinFreq​

A Double specifying the minimum frequence.

The default value is DFLT_DBL.

iNumFreqPoint​

An Integer specifying the number frequence point.

The default value is DFLT_INT.

dBiasParam​

A Double specifying the bias param.

The default value is DFLT_DBL.

iPropMethod​

An Integer specifying the property method.

The default value is 0.

iPSDtype​

An Integer specifying the PSD type.

The default value is -1.

iPSDdir​

An Integer specifying the PSD ddir.

The default value is 0.

crPSDLoad​

A Cursor specifying the PSD load.

The default value is None.

dPSDFactor​

A Double specifying the PSD factor.

The default value is DFLT_DBL.

dGravityAccel​

A Double specifying the gravity accel.

The default value is DFLT_DBL.

iOutputEigenFreqStep​

An Integer specifying the output eigen frequence step.

The default value is -1.

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

The default value is -1.

strRefPath​

A String specifying the reference path.

The default value is "".

listAdvcRefStressResult​

A ADVC_REF_STRESS_RESULT List specifying the advc reference stress result.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.ADVC.MakeProcess.RandomResponse(strName="", strRefEigenDir="", dRefLowFreq=DFLT_DBL, dRefHighFreq=DFLT_DBL, crModalDampingRatio=None, crExcitationFreq=None, bAutoFreqInterval=False, dMaxFreq=DFLT_DBL, dMinFreq=DFLT_DBL, iNumFreqPoint=DFLT_INT, dBiasParam=DFLT_DBL, iPropMethod=0, iPSDtype=-1, iPSDdir=0, crPSDLoad=None, dPSDFactor=DFLT_DBL, dGravityAccel=DFLT_DBL, iOutputEigenFreqStep=-1, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath="", listAdvcRefStressResult=[])
