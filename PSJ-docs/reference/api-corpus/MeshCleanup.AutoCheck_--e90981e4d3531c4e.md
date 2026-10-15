# MeshCleanup.AutoCheck()

MeshCleanup.AutoCheck()

Description​

Check meshing quality

Syntax​

MeshCleanup.AutoCheck(crlParts, iElemType, blCheckCondition, blElemQuality, dlLimitValue, crlElems)

Ribbon: MeshCleanup » AutoCheck

Inputs​

crlParts​

A List of Cursor specifying the part.

This is a required input.

iElemType​

An Integer specifying the element type.

This is a required input.

blCheckCondition​

A Boolean List specifying the check condition.

This is a required input.

blElemQuality​

A Boolean List specifying the element quality.

This is a required input.

dlLimitValue​

A Double List specifying the limit value.

This is a required input.

crlElems​

A List of Cursor specifying the element.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.AutoCheck(crlParts, iElemType, blCheckCondition, blElemQuality, dlLimitValue, crlElems)
