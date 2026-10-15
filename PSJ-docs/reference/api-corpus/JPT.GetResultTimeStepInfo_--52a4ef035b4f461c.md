# JPT.GetResultTimeStepInfo()

JPT.GetResultTimeStepInfo()

Description​

Get the relating information of the inputted result step with it's time step.

Syntax​

JPT.GetResultTimeStepInfo(PostAnalysisType,
                          resultSet,
                          timeStep)

Inputs​

PostAnalysisType​

An Enum specifying the PostAnalysisType describing the type of analysis result.

This is a required input.

resultSet​

An Integer specifying the step ID of the imported result.

This is a required input.

timeStep​

An Integer specifying the time step of the imported result.

This is a required input.

Return Code​

A PostTimeStepInfo object specifying the information relating to the inputted time step.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_time_step_info = JPT.GetResultTimeStepInfo(JPT.PostAnalysisType.POST_ANALYSIS_MODAL,
                                           1,
                                           10)

JPT.Debugger(result_time_step_info)

print(result_time_step_info.mode)
print(result_time_step_info.time)
print(result_time_step_info.freq)
