# MeshEdit.MergeNodes()

MeshEdit.MergeNodes()

Description​

Merge nodes

Syntax​

MeshEdit.MergeNodes(dTolerance=0.01, iKeepType=0, crlTargets=[], bGroup=False, bEquivalence=True)

Ribbon: MeshEdit » MergeNodes

Inputs​

dTolerance​

A Double specifying the tolerance.

The default value is 0.01.

iKeepType​

An Integer specifying the keep type.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

bGroup​

A Boolean specifying the group.

The default value is False.

bEquivalence​

A Boolean specifying the equivalence.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.MergeNodes(dTolerance=0.01, iKeepType=0, crlTargets=[], bGroup=False, bEquivalence=True)
