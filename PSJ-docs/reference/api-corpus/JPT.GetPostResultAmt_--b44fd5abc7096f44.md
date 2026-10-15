# JPT.GetPostResultAmt()

JPT.GetPostResultAmt()

Description​

Get Physical Amount information of the specify result.

Syntax​

JPT.GetPostResultAmt(PostAnalysisType,
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

An Integer specifying the Physical Amount type of the working result.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, \
                               1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

amt_info = JPT.GetPostResultAmt(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                               1,
                               1,
                               "Stress",
                               "XX",
                               JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT_NODE)
JPT.Debugger(amt_info)
