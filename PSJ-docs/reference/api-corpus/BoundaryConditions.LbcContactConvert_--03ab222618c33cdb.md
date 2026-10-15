# BoundaryConditions.LbcContactConvert()

BoundaryConditions.LbcContactConvert()

Description​

BoundaryConditions LbcContactConvert

Syntax​

BoundaryConditions.LbcContactConvert(...)

Ribbon: BoundaryConditions » LbcContactConvert

Inputs​

iConvertTo​

An Integer specifying the convert to.

This is a required input.

iTieConvType​

An Integer specifying the tie conv type.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LbcContactConvert(iConvertTo, iTieConvType, crlTargets)
