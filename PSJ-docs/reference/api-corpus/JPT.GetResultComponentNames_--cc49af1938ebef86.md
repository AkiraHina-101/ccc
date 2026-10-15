# JPT.GetResultComponentNames()

JPT.GetResultComponentNames()

Description​

Get all the available result directions of the inputted result type.

Syntax​

JPT.GetResultComponentNames(PostAnalysisType,
                            resultSet,
                            timeStep,
                            resultName,
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

resultName​

A String specifying the type of result (Such as Displacement, Stress, etc.).

This is a required input.

BoolType​

An Enum specifying the BoolType describing the selection:

True: Select the inputted entity with its ID.

False: Deselect the inputted entity with its ID.

This is a required input.

Return Code​

A List of String containing all the available data directions of the inputted result type.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

steps=JPT.GetResultSteps()
for step in steps:
    incs=JPT.GetResultIncrements(step.first, step.third)
    for inc in incs:
        result_comp_name = JPT.GetResultComponentNames(step.first,     # analysis type
                                                       step.third,     # result set
                                                       inc,            # time step
                                                       "Displacement", # result name
                                                       JPT.BoolType.TRUE_VAL)

        JPT.Debugger(result_comp_name)
