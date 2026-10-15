# Analysis.Ansys.Steady()

Analysis.Ansys.Steady()

Description​

Export the Ansys Steady Static Heat Transfer solver file

Syntax​

Analysis.Ansys.Steady(...)

Ribbon: Analysis » Ansys » Steady

Inputs​

strName​

A String specifying the job name of Ansys analysis.

This is a required input.

strAnsysJobName​

A String specifying the the name of Ansys Steady Static Heat Transfer analysis.

The default value is "Job1".

strJobName​

A String specifying the description for new Ansys analysis.

The default value is "".

ansysAnalysisBasic​

A BASIC specifying the Ansys Analysis - Linear Static Structure input parameter.

The default value is BASIC.

bRunAPDL​

A Boolean enable/disalbe the option that running Ansys Parametric Design Language (APDL).

The default value is False.

bWriteResultDB​

A Boolean enable/disalbe the option that write result database.

The default value is False.

iLoadCaseId​

An Integer specifying the load case identify number .

The default value is 0.

ansysAnalysisSteadyStatic​

A STEADY_STATIC specifying the Ansys Analysis - Steady Static Heat Transfer input parameter.

The default value is STEADY_STATIC.

strAnsysVersion​

A String specifying the Ansys Version information.

The default value is "".

strCommandLineOption​

A String specifying the Command Line Option information.

The default value is "".

bOutputSOLVE​

A Boolean enable/disalbe SOLVE command write out.

The default value is False.

crEdit​

A Cursor specifying the editing ansys job.

The default value is None.

strFileName​

A String specifying the exporting path for .dat file.

The default value is "".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Analysis.Ansys.Steady("Job1", ansysAnalysisBasic=BASIC(dTimeStepSize=1.0, dMinTimeStep=1.0),
    iLoadCaseId=1, ansysAnalysisSteadyStatic=STEADY_STATIC(bSteadyStaticMemorySave=True), strFileName="D:/Job1.dat")
