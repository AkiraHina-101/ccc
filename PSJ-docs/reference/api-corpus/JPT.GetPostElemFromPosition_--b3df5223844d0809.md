# JPT.GetPostElemFromPosition()

JPT.GetPostElemFromPosition()

Description​

Get post element from a specific position.

Syntax​

JPT.GetPostElemFromPosition(xCoordValue,
                            yCoordValue,
                            zCoordValue,
                            dTolerance,
                            bVisible)

Inputs​

xCoordValue​

A Double specifying the value in X coordinate (Cartesian coordinate system).

This is a required input.

yCoordValue​

A Double specifying the value in Y coordinate (Cartesian coordinate system).

This is a required input.

zCoordValue​

A Double specifying the value in Z coordinate (Cartesian coordinate system).

This is a required input.

dTolerance​

A Double specifying the tolerance to search the satisfying element. This argument will help to find the first nearest element with the input position.

This is a required input.

bVisible​

A Boolean specifying the search mode.
True: Only search for elements which is displayed on the screen

False: Enable to search in the hidden elements

This is a required input.

Return Code​

A DPostElem object containing the Post Element information.

Sample Code​

JPT.ClearLog()
# Set up model path
JupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
modelPath = JupiterPath + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"

# Import result
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 1, 1, 1)'.format(modelPath))
JPT.ViewFitToModel()

# Show Result
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Mises, 2}, {2, 0, 0, 0, 0, 0, 0, 0.000000, 0}, \
0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
{0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')
JPT.Exec('CmdShowPostDeformation(183:1, 1, 0, 1, 1, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)')

# Get Element by position
elemWith_Tolerance = JPT.GetPostElemFromPosition(16, 20, 5, 0.1, 1)
JPT.Debugger(elemWith_Tolerance) #Element ID = 409
