# JPT.GetMinResultValue()

JPT.GetMinResultValue()

Description​

Get the minimum value of the current plotting result.

Syntax​

JPT.GetMinResultValue(...)

Inputs​

This utility function does not require any input value.

Return Code​

bVisible ​

An Bool specifying whether to restrict the target to only visible entity (True) or not(False)

The default value is False.

注記

In case the result has not been plotted yet, this utility will return -1.7976931348623157e+308.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

# Get the minimum value of the plotting result
minResult = JPT.GetMinResultValue()
JPT.Debugger(minResult)
