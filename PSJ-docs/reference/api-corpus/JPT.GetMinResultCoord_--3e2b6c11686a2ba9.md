# JPT.GetMinResultCoord()

JPT.GetMinResultCoord()

Description​

Get coordinate of the node/center node of the element having the minimum value of the plotting result.

Syntax​

JPT.GetMinResultCoord(...)

Inputs​

bVisible ​

An Bool specifying whether to restrict the target to only visible entity (True) or not(False)

The default value is False.

Return Code​

A DoubleVector specifying the coordinate of the node/center node of the element (Based on the Display At type) having the minimum value of the plotting result.

note

In case the result has not been plotted yet, this utility will return a list = [-1.79769e+308, -1.79769e+308, -1.79769e+308].

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, 0)')

# Get the coordinate of the node having the minimum value of the plotting result
minNodeCoord = JPT.GetMinResultCoord()
JPT.Debugger(minNodeCoord)

# Get the coordinate of the center of an element having the minimum value of the plotting result
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

minElemCenterCoord = JPT.GetMinResultCoord()
JPT.Debugger(minElemCenterCoord)
