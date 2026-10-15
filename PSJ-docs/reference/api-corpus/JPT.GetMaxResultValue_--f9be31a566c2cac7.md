# JPT.GetMaxResultValue()

JPT.GetMaxResultValue()

Description​

Get the maximum value of the current plotting result.

Syntax​

JPT.GetMaxResultValue()

Inputs​

This utility function does not require any input value.

Return Code​

An Integer specifying the maximum value of the plotting result.

note

In case the result has not been plotted yet, this utility will return -1.7976931348623157e+308.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

# Get the maximum value of the plotting result
maxResult = JPT.GetMaxResultValue()
JPT.Debugger(maxResult)
