# ViewSelectByFace()

ViewSelectByFace()

Description​

Select all targets in the same plane as the selected targets.

Syntax​

ViewSelectByFace(int TargetType, cursor[] Targets)

Inputs​

1. Int​

An Integer specifying the target type to be selected.

2. Cursor[]​

A Cursor List specifying the targets to select other targets in the same plane as them.

Return Code​

A Cursor List specifying the selected parts (faces or 2D elements).

Sample Code​

ViewSelectByFace(3,[])
