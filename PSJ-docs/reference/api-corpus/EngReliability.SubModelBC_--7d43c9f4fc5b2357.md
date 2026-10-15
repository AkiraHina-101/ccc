# EngReliability.SubModelBC()

EngReliability.SubModelBC()

Description​

Create mapping forced displacement

Syntax​

EngReliability.SubModelBC(strName, crlTargets, iPos, iViewCp, iCp, iSrcType, iMappedCpIndexArr0, dScaleR, vecOffset, vecRotate, dScaleT, strPath, crEdit, iMappingMethod, iSubmodelBCMappingType, iMappingFromStepNo, bSetADVCFile, strADVCResultFile, bSetDetATol, dDetATol, bSetElementSet, strElementSet)

Ribbon: EngReliability » SubModelBC

Inputs​

strName​

A String specifying the name.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

iPos​

An Integer specifying the position.

This is a required input.

iViewCp​

An Integer specifying the view component.

This is a required input.

iCp​

An Integer specifying the component.

This is a required input.

iSrcType​

An Integer specifying the source type.

This is a required input.

iMappedCpIndexArr0​

An Integer specifying the mapped component index arr0.

This is a required input.

dScaleR​

A Double specifying the scale r.

This is a required input.

vecOffset​

A Vector specifying the offset.

This is a required input.

vecRotate​

A Vector specifying the rotate.

This is a required input.

dScaleT​

A Double specifying the scale t.

This is a required input.

strPath​

A String specifying the path.

This is a required input.

crEdit​

A Cursor specifying the edit.

This is a required input.

iMappingMethod​

An Integer specifying the mapping method.

This is a required input.

iSubmodelBCMappingType​

An Integer specifying the submodel c mapping type.

This is a required input.

iMappingFromStepNo​

An Integer specifying the mapping from step no.

This is a required input.

bSetADVCFile​

A Boolean specifying the set ADVC file.

This is a required input.

strADVCResultFile​

A String specifying the ADVC result file.

This is a required input.

bSetDetATol​

A Boolean specifying the set det a tolerance.

This is a required input.

dDetATol​

A Double specifying the det a tolerance.

This is a required input.

bSetElementSet​

A Boolean specifying the set element set.

This is a required input.

strElementSet​

A String specifying the element set.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

EngReliability.SubModelBC(strName, crlTargets, iPos, iViewCp, iCp, iSrcType, iMappedCpIndexArr0, dScaleR, vecOffset, vecRotate, dScaleT, strPath, crEdit, iMappingMethod, iSubmodelBCMappingType, iMappingFromStepNo, bSetADVCFile, strADVCResultFile, bSetDetATol, dDetATol, bSetElementSet, strElementSet)
