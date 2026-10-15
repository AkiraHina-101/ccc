# SetHidingElementFactor()

SetHidingElementFactor()

Description​

Set Optimized Shape value and result that is threshold for being a hidden element.

Syntax​

SetHiddingElementFactor(float OptimizedShape, string ResultName)

Inputs​

1. float ​

Specify Optimized Shape value to hide element.

2. string ​

Specify result to use as hiding elemet source. "NodalDensityRatio" or "DensityRatio".

Return Code​

Nothing.

Sample Code​

SetHidingElementFactor(0.28, "NodalDensityRatio")
