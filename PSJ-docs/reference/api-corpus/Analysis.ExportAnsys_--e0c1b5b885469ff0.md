# Analysis.ExportAnsys()

Analysis.ExportAnsys()

Description​

Export Ansys Analysis Job.
*This command is no more displayed in the latest Jupiter.

Syntax​

Analysis.ExportAnsys(...)

Macro: ExportAnsys

Ribbon: Analysis » ExportAnsys

Inputs​

strName​

A String specifying the destination path file to export.

The default value is "".

crAnsysJob​

A Cursor specifying the Ansys analysis job.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Analysis.Ansys.LinearStatic(strJobName="Job_1", iJobdataAnatype=1, iJobdataSoltype=3, strJobdataJobname="Job_1",
    bBasicdataBoutputdisplacements=True, bBasicdataBoutputstress=True, iLCId=1, dTransientdataFalpha=0.252506)

Analysis.ExportAnsys(strName="D:/Job_1.dat", crAnsysJob=AnsysJob(1))
