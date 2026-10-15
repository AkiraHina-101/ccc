# MeshCleanup.ManualCheck()

MeshCleanup.ManualCheck()

Description​

MeshCleanup ManualCheck

Syntax​

MeshCleanup.ManualCheck(crlParts=[], iElemType=0, iVeQuality=0, iCheckCondition=0, dLimitValue=0.0, dCFLValue=0.0, iNonManifold=0, iCleanupMode=0, crlElems=[])

Ribbon: MeshCleanup » ManualCheck

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

iElemType​

An Integer specifying the element type.

The default value is 0.

iVeQuality​

An Integer specifying the ve quality.

The default value is 0.

iCheckCondition​

An Integer specifying the check condition.

The default value is 0.

dLimitValue​

A Double specifying the limit value.

The default value is 0.0.

dCFLValue​

A Double specifying the c l value.

The default value is 0.0.

iNonManifold​

An Integer specifying the non manifold.

The default value is 0.

iCleanupMode​

An Integer specifying the cleanup mode.

The default value is 0.

crlElems​

A List of Cursor specifying the element.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.ManualCheck(crlParts=[], iElemType=0, iVeQuality=0, iCheckCondition=0, dLimitValue=0.0, dCFLValue=0.0, iNonManifold=0, iCleanupMode=0, crlElems=[])
