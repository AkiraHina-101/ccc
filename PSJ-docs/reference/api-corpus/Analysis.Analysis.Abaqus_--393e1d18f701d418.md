# Analysis.Analysis.Abaqus()

Analysis.Analysis.Abaqus()

Description​

Unknown Description

Syntax​

Analysis.Abaqus(strName, bRBE2toMPC, bRenameProcess, iCodeType, 
    iSurfDefType, iUnit, iWriteType, strDescription, crlStepSequence, 
    crEdit, strlUserText, bExptNdEleGroups, bDeleteFloatingNodes, 
    bExptFaceElemGroups2Surface, bLoadCase, bAutoAssignDummyProperty, crDummyMat)

Macro: CreateAbaqusJob

Ribbon: Analysis » Analysis » Abaqus

Inputs​

strName​

A String specifying the name.

This is a required input.

bRBE2toMPC​

A Boolean specifying the RBE2 to MPC.

This is a required input.

bRenameProcess​

A Boolean specifying the rename process.

This is a required input.

iCodeType​

An Integer specifying the code type.

This is a required input.

iSurfDefType​

An Integer specifying the surface definition type.

This is a required input.

iUnit​

An Integer specifying the unit.

This is a required input.

iWriteType​

An Integer specifying the write type.

This is a required input.

strDescription​

A String specifying the description.

This is a required input.

crlStepSequence​

A List of Cursor specifying the step sequence.

This is a required input.

crEdit​

A Cursor specifying the edit.

This is a required input.

strlUserText​

A List of String specifying the user text.

This is a required input.

bExptNdEleGroups​

A Boolean specifying the exeption nd element groups.

This is a required input.

bDeleteFloatingNodes​

A Boolean specifying the delete floating nodes.

This is a required input.

bExptFaceElemGroups2Surface​

A Boolean specifying the exeption face element groups2 surface.

This is a required input.

bLoadCase​

A Boolean specifying the load case.

This is a required input.

bAutoAssignDummyProperty​

A Boolean specifying the auto assign dummy property.

This is a required input.

crDummyMat​

A Cursor specifying the dummy material.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.Analysis.Abaqus(strName, bRBE2toMPC, bRenameProcess, iCodeType, iSurfDefType, iUnit, iWriteType, strDescription, crlStepSequence, crEdit, strlUserText, bExptNdEleGroups, bDeleteFloatingNodes, bExptFaceElemGroups2Surface, bLoadCase, bAutoAssignDummyProperty, crDummyMat)
