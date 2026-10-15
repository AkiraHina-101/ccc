# Analysis.ACTRAN.Run()

Analysis.ACTRAN.Run()

Description​

Unknown Description

Syntax​

Analysis.ACTRAN.Run(...)

Ribbon: Analysis » ACTRAN » Run

Inputs​

actranAnalysis​

A ACTRAN_ANALYSIS specifying the Actran analysis data structure.

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

Analysis.ACTRAN.Run(actranAnalysis=ACTRAN_ANALYSIS(), crlTargets=[], crEdit=None)
