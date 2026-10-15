# Analysis.ADVC.MakeProcess.Fatigue()

Analysis.ADVC.MakeProcess.Fatigue()

Description​

Create ADVC fatigue process.

Syntax​

Analysis.ADVC.MakeProcess.Fatigue(...)

Macro: AdvcFatigueProcess

Ribbon: Analysis » ADVC » MakeProcess » Fatigue

Inputs​

strName​

A String specifying the name.

The default value is "".

bFatigue​

A Boolean specifying the fatigue.

The default value is False.

iMethod​

An Integer specifying the method.

The default value is 0.

iStressAxis​

An Integer specifying the stress axis.

The default value is 0.

iSafetyType​

An Integer specifying the safety type.

The default value is 0.

dSearchResolution​

A Double specifying the search resolution.

The default value is DFLT_DBL.

dSafetyMax​

A Double specifying the safety maximum.

The default value is DFLT_DBL.

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

Analysis.ADVC.MakeProcess.Fatigue(strName="", bFatigue=False, iMethod=0, iStressAxis=0, iSafetyType=0, dSearchResolution=DFLT_DBL, dSafetyMax=DFLT_DBL, crEdit=None, listLoadNode=[], listLoadCaseNode=[], listLoadNodeContact=[], ilOutputParamList=[], iRefType=-1, strRefPath="", listAdvcRefStressResult=[])
