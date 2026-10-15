# MeshCleanup.CorrectModel()

MeshCleanup.CorrectModel()

Description​

Correct model

Syntax​

MeshCleanup.CorrectModel(crlParts, iEnableBreakEdge=0, dEdgeAngle=0, iEnableMergeEdge=0, dMergeEdgeAngle=0, iEnableMergePlanarFace=0, iEnableRemoveExtraVertex=0)

Ribbon: MeshCleanup » CorrectModel

Inputs​

crlParts​

A List of Cursor specifying the part.

This is a required input.

iEnableBreakEdge​

An Integer specifying the enable break edge.

The default value is 0.

dEdgeAngle​

A Double specifying the edge angle.

The default value is 0.

iEnableMergeEdge​

An Integer specifying the enable merge edge.

The default value is 0.

dMergeEdgeAngle​

A Double specifying the merge edge angle.

The default value is 0.

iEnableMergePlanarFace​

An Integer specifying the enable merge planar face.

The default value is 0.

iEnableRemoveExtraVertex​

An Integer specifying the enable remove extra vertex.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.CorrectModel(crlParts, iEnableBreakEdge=0, dEdgeAngle=0, iEnableMergeEdge=0, dMergeEdgeAngle=0, iEnableMergePlanarFace=0, iEnableRemoveExtraVertex=0)
