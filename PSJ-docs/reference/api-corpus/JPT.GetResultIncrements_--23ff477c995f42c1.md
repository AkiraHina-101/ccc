# JPT.GetResultIncrements()

JPT.GetResultIncrements()

Description​

Get all the existing increments of the inputted result step.

Syntax​

JPT.GetResultIncrements(PostAnalysisType,
                        resultSet)

Inputs​

PostAnalysisType​

An Enum specifying the PostAnalysisType describing the type of analysis result.

This is a required input.

resultSet​

An Integer specifying the step ID of the imported result.

This is a required input.

Return Code​

A List of Integer containing all the existing increments of the inputted result type with it's step.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_increments = \
    JPT.GetResultIncrements(JPT.PostAnalysisType.POST_ANALYSIS_MODAL,
                            1)

JPT.Debugger(result_increments)
