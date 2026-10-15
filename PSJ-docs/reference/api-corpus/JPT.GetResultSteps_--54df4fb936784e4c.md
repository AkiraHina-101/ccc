# JPT.GetResultSteps()

JPT.GetResultSteps()

Description​

Get all the existing result types and their time steps of the current result.

Syntax​

JPT.GetResultSteps()

Inputs​

This utility function does not require any input value.

Return Code​

A List of Integer Pair containing information of result types, id and their steps.

注記

To get their output values, you can use the below code (as an example):

result_types_steps = JPT.GetResultSteps()
for item in result_types_steps:
    result_type = item.first
    result_step = item.second
    print("Result type: " + str(result_type))
    print("Result step: " + str(result_step))

For your reference, to printout all the properties and methods of the JPT.GetResultSteps() API, you can use print(dir(JPT.GetResultSteps())).

Besides, the output value is an integer number that specifying the result type. So, for checking the available result type, you can refer to PostAnalysisTypes.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_types_steps = JPT.GetResultSteps()

print("Result type: " + str(result_types_steps[0].first)) #2: JPT.PostAnalysisType.POST_ANALYSIS_MODAL
print("Result step: " + str(result_types_steps[0].second))
