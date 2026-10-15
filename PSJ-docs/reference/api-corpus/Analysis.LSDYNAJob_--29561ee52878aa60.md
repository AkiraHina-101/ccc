# Analysis.LSDYNAJob()

Analysis.LSDYNAJob()

Description​

Create LS-Dyna Analysis Job.

Syntax​

Analysis.LSDYNAJob(...)

Ribbon: Analysis » LSDYNAJob

Inputs​

crEdit​

A Cursor specifying the existed analysis job to modify it instead of creating a new ones.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Analysis.LSDYNAJob()
