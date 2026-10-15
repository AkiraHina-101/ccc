# JPT.GetResultUseIncrement()

JPT.GetResultUseIncrement()

Description​

Check whether the result having any increment or not.

Syntax​

JPT.GetResultUseIncrement(PostAnalysisType,
                          resultSet)

Inputs​

PostAnalysisType​

An Enum specifying the PostAnalysisType describing the type of analysis result.

This is a required input.

resultSet​

An Integer specifying the step ID of the imported result.

This is a required input.

Return Code​

A Boolean specifying the existence of the increment of the inputted time step.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

is_increment_exist = \
    JPT.GetResultUseIncrement(JPT.PostAnalysisType.POST_ANALYSIS_MODAL, 0)

JPT.Debugger(is_increment_exist)
