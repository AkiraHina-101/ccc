# MeshCleanup.ManualCheck.Tri()

MeshCleanup.ManualCheck.Tri()

Description​

Unknown Description

Syntax​

MeshCleanup.ManualCheck.Tri(crlParts=[], nElemType=0, veQuality=0, nCheckCondition=0, dLimitValue=0.0, CFLValue=0.0, nNonManifold=0, nCleanupMode=0, crlElems=[])

Ribbon: MeshCleanup » ManualCheck » Tri

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

nElemType​

A N_ELEM_TYPE specifying the element type.

The default value is 0.

veQuality​

A VE_QUALITY specifying the quality.

The default value is 0.

nCheckCondition​

A N_CHECK_CONDITION specifying the check condition.

The default value is 0.

dLimitValue​

A Double specifying the limit value.

The default value is 0.0.

CFLValue​

A CFLVALUE specifying the l value.

The default value is 0.0.

nNonManifold​

A N_NON_MANIFOLD specifying the non manifold.

The default value is 0.

nCleanupMode​

A N_CLEANUP_MODE specifying the cleanup mode.

The default value is 0.

crlElems​

A List of Cursor specifying the element.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.ManualCheck.Tri(crlParts=[], nElemType=0, veQuality=0, nCheckCondition=0, dLimitValue=0.0, CFLValue=0.0, nNonManifold=0, nCleanupMode=0, crlElems=[])
