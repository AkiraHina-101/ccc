# Analysis.ACTRAN.CreateEdat()

Analysis.ACTRAN.CreateEdat()

Description​

Unknown Description

Syntax​

Analysis.ACTRAN.CreateEdat(...)

Ribbon: Analysis » ACTRAN » CreateEdat

Inputs​

actranAnalysis​

An ACTRAN_ANALYSIS specifying the Actran analysis data structure.

The default value is ACTRAN_ANALYSIS.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.ACTRAN.CreateEdat(actranAnalysis=ACTRAN_ANALYSIS(), crlTargets=[], crEdit=None)
