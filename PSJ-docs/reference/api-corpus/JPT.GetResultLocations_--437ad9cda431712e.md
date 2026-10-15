# JPT.GetResultLocations()

JPT.GetResultLocations()

Description​

Get all the available data location existing on the inputted result type and direction.

Syntax​

JPT.GetResultLocations(PostAnalysisType,
                       resultSet,
                       timeStep,
                       resultName,
                       componentName)

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

componentName​

A String specifying a specific direction of the result (Such as X, Y, Z, etc.).

This is a required input.

Return Code​

A List of Integer containing all the available PostResultDataLoc of the inputted result type and it's direction.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_location = \
    JPT.GetResultLocations(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                           1,
                           1,
                           "Stress",
                           "XX")

JPT.Debugger(result_location)
#2: JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT
#4: JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT_NODE
