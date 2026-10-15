# JPT.GetResultByElemId()

JPT.GetResultByElemId()

Description​

Get the result value of specified Element by ID.

Syntax​

JPT.GetResultByElemId(elementID)

Inputs​

elementID​

An Integer specifying the ID of Element to be checked the result value.

This is a required input.

Return Code​

A Double specifying the result of Element.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XX, 2}, {2, 1, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, 0)')

# Get the result value of Element ID = 658
valueElementID = JPT.GetResultByElemId(658)
print("Stress of XX component of Element ID = 658: " + str(valueElementID))
