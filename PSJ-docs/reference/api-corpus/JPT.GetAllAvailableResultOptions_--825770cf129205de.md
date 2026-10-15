# JPT.GetAllAvailableResultOptions()

JPT.GetAllAvailableResultOptions()

Description​

Get all available result options of the inputted result type.

Syntax​

JPT.GetAllAvailableResultOptions(PostAnalysisType,
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

A List of PostDataOp objects specifying all available settings of the working result.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

all_available_result_options_vector = \
    JPT.GetAllAvailableResultOptions(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                                     1,
                                     1,
                                     "Stress",
                                     "XX",
                                     JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT_NODE
                                    )

JPT.Debugger(all_available_result_options_vector)

for available_PostDataOp in all_available_result_options_vector:
    #Component of AvailablePostDataOp
    print("---------------------------------")
    print("Location: " + str(available_PostDataOp.loc))
    print("Conversion: " + str(available_PostDataOp.cnv))
    print("Continuously: " + str(available_PostDataOp.cont))
    print("Coordinate: " + str(available_PostDataOp.coord))
    print("Load 1D: " + str(available_PostDataOp.load1d))
    print("Load 2D: " + str(available_PostDataOp.load2d))
    print("Complex: " + str(available_PostDataOp.complex))
    print("Phase Angle: " + str(available_PostDataOp.phaseAngle))
    print("User Coordinate ID: " + str(available_PostDataOp.userCoordSysId))
