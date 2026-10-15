# JPT.GetResultSetNameWithAnalysisID()

JPT.GetResultSetNameWithAnalysisID()

Description​

Get the name of Result Set (Subcase).

Syntax​

JPT.GetResultSetNameWithAnalysisID(PostAnalysisType,
                     analysisID,
                     resultSet)

Inputs​

PostAnalysisType​

An Enum specifying the PostAnalysisType describing the type of analysis result.

This is a required input.

analysisID​

An Integer specifying the analysis ID of the imported result.

This is a required input.

resultSet​

An Integer specifying the step ID of the imported result.

This is a required input.

Return Code​

A String specifying the name of Result Set (Subcase).

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_set_name = JPT.GetResultSetNameWithAnalysisID(1,0,1)
JPT.Debugger(result_set_name)
