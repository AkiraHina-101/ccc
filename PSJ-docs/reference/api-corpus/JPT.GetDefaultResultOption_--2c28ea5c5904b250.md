# JPT.GetDefaultResultOption()

JPT.GetDefaultResultOption()

Description​

Get default result option setting of the inputted result type.

Syntax​

JPT.GetDefaultResultOption(PostAnalysisType,
                           resultSet,
                           timeStep,
                           resultName,
                           componentName,
                           PostResultDataLoc)

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

PostResultDataLoc​

An Enum specifying the PostResultDataLoc describing the location of result (Such as on node, on element, etc.).

This is a required input.

Return Code​

A PostDataOp object containing the default setting of the working result.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

default_result_option = \
    JPT.GetDefaultResultOption(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                               1,
                               1,
                               "Displacement",
                               "X",
                               1)

JPT.Debugger(default_result_option)

# Component of PostDataOp
print("Location: " + str(default_result_option.loc))
print("Conversion: " + str(default_result_option.cnv))
print("Continuously: " + str(default_result_option.cont))
print("Coordinate: " + str(default_result_option.coord))
print("Load 1D: " + str(default_result_option.load1d))
print("Load 2D: " + str(default_result_option.load2d))
print("Complex: " + str(default_result_option.complex))
print("Phase Angle: " + str(default_result_option.phaseAngle))
print("User Coordinate ID: " + str(default_result_option.userCoordSysId))
