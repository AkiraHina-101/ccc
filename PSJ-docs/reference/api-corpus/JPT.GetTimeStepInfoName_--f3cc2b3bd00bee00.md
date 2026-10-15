# JPT.GetTimeStepInfoName()

JPT.GetTimeStepInfoName()

Description​

Get the name of Time Step Info.

Syntax​

JPT.GetTimeStepInfoName(PostAnalysisType,
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

A String specifying the name of Time Step information.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

time_step_info_name = JPT.GetTimeStepInfoName(2,1,1)
JPT.Debugger(time_step_info_name) # Mode 1, Freq=3.235953e+04
