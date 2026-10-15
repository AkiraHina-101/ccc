# Analysis.ExportLsdyna()

Analysis.ExportLsdyna()

Description​

Export LS-Dyna Analysis Job.

Syntax​

Analysis.ExportLsdyna(...)

Ribbon: Analysis » ExportLsdyna

Inputs​

strPath​

A String specifying the destination path file to export.

The default value is "".

crJob​

A Cursor specifying the LS-Dyna analysis job.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=12999622)

Analysis.LSDYNAJob()

Analysis.ExportLsdyna(strPath="C:/Job_1.k", crJob=LSDynaJob(1))
