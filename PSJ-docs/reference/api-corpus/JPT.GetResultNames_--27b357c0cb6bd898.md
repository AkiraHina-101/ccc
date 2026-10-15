# JPT.GetResultNames()

JPT.GetResultNames()

Description​

Get all the available result type existing on the model.

Syntax​

JPT.GetResultNames(PostAnalysisType,
                   resultSet,
                   timeStep,
                   BoolType)

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

BoolType​

An Enum specifying the BoolType describing the selection:

True: Select the inputted entity with its ID.

False: Deselect the inputted entity with its ID.

This is a required input.

ヒント

You also can input 1 or True instead of inputting JPT.BoolType.TRUE_VAL

You also can input 0 or False instead of inputting JPT.BoolType.FALSE_VAL

Return Code​

A List of String containing all the available result types existing on the model.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_name = JPT.GetResultNames(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                                 1,
                                 1,
                                 JPT.BoolType.TRUE_VAL)

JPT.Debugger(result_name)
