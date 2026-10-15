# AcousticIntensity()

AcousticIntensity()

Description​

Intensity is created from the sound pressure and particle velocity results.

Syntax​

AcousticIntensity(str strAnalysisName, cursor crEdit)

Inputs​

1. int​

The name of the analysis.

2. cursor​

A Cursor specifying the edit.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AcousticIntensity("MyAcousticIntensity", 0:0)
