# Analysis.Ansys.Harmonic()

Analysis.Ansys.Harmonic()

Description​

Export the Ansys Harmonic Structural solver file.

Syntax​

Analysis.Ansys.Harmonic(...)

Ribbon: Analysis » Ansys » Harmonic

Inputs​

strJobName​

A String specifying the job name of Ansys analysis.

This is a required input.

strAnsysJobName​

A String specifying the the name of Ansys NorHarmonic Structural analysis.

The default value is "Job1".

strAnsysJobdescription​

A String specifying the description for new Ansys analysis.

The default value is "".

bRunAPDL​

A Boolean enable/disalbe the option that running Ansys Parametric Design Language (APDL).

The default value is False.

bWriteResultDB​

A Boolean enable/disalbe the option that write result database.

The default value is False.

dAnsysAnalysisEndFreq​

A Double specifying the end frequency number.

The default value is DFLT_DBL.

dAnsysAnalysisStartFreq​

A Double specifying the start frequency number.

The default value is DFLT_DBL.

ansysAnalysisHarmonic​

A HARMONIC specifying the Ansys Analysis - Hamonic Structural input parameter.

The default value is HARMONIC.

iLoadCaseId​

An Integer specifying the load case identify number.

The default value is 0.

ansysAnalysisModal​

A MODAL specifying the Ansys Analysis - Modal Structural input parameter.

The default value is MODAL.

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

Analysis.Ansys.Harmonic("Job1", ansysAnalysisHarmonic=HARMONIC(bHarmonicOutputDisplacements=True),
    iLoadCaseId=1, strFileName="C:/Job1.dat")
