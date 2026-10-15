# Analysis.ADVC.MakeProcess.ModalFreqResp()

Analysis.ADVC.MakeProcess.ModalFreqResp()

Description​

Create an ADVC Modal Frequency Response process.
This process could be created in one time or multiple times.

Syntax​

Analysis.ADVC.MakeProcess.ModalFreqResp(...)

Macro: AdvcModalFreqRespProcess

Ribbon: Analysis » ADVC » Structure » ModalFreqResp

Inputs​

strName​

A String specifying the process name of ADVC - Modal Frequency Response process.

This is a required input.

strRefEigenDir​

A String specifying the reference eigen direction which is the path of a folder.

The default value is "".

dRefLowFreq​

A Double specifying the reference low frequency.

The default value is DFLT_DBL.

dRefHighFreq​

A Double specifying the reference high frequency.

The default value is DFLT_DBL.

crModalDampingRatio​

A Cursor specifying the modal damping ratio.

The default value is None.

crExcitationFreq​

A Cursor specifying the excitation frequency.

The default value is None.

bAutoFreqInterval​

A Boolean specifying whether to enable the auto frequency interval or not.

If True: All settings of frequency interval will be able to use.

If False: All settings of frequency interval won't be able to use.

The default value is False.

dMaxFreq​

A Double specifying the maximum frequency.

The default value is DFLT_DBL.

dMinFreq​

A Double specifying the minimum frequency.

The default value is DFLT_DBL.

iNumFreqPoint​

An Integer specifying the number frequency point.

The default value is DFLT_INT.

dBiasParam​

A Double specifying the bias parameter.

The default value is DFLT_DBL.

crEdit​

A Cursor specifying an ADVC Modal Frequency Response process.

If this parameter is used, the specified job will be modified.

If it is left None, a new job will be created.

The default value is None.

listLoadNode​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned loads in the model.

The default value is [].

listLoadCaseNode​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned load cases in the model.

The default value is [].

listLoadNodeContact​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned contacts in the model.

The default value is [].

ilOutputParamList​

A List of Integer specifying the list of output request for the result type such as Displacement, Stress, Strain,...

The default value is [].

iRefType​

An Integer specifying the result reference type.

If iRefType=0: Temperature Load

If iRefType=1: Stress

The default value is 0.

strRefPath​

A String specifying the path of reference result.

The default value is "".

listAdvcRefStressResult​

A List of ADVC_REF_STRESS_RESULT specifying the list of data of Reference Result.

The default value is [].

Return Code​

A Cursor specifying the newly created or the modified ADVC Modal Frequency Response process.

Sample Code​

Geometry.Part.Cube()

process = Analysis.ADVC.MakeProcess.ModalFreqResp(strName="Process_0", listLoadNode=[],
    listLoadCaseNode=[], listLoadNodeContact=[], listAdvcRefStressResult=[])
print(str(process)) #for checking return value
