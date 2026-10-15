# JPT.GetAllPostNodes()

JPT.GetAllPostNodes()

Description​

Get all the information of all existing Post (read-only) nodes.

Syntax​

JPT.GetAllPostNodes()

Inputs​

This utility function does not require any input value.

Return Code​

A PostNodeVector object or List of DPostNode objects containing all the information of all the existing nodes.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Displacement, X, 1}, {1, 1, 0, \
                             0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
                             {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
                             {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# Get the result values of Nodes
for postNode in JPT.GetAllPostNodes():
    value=JPT.GetResultByNodeId(postNode.id)
    print(f"Displacement of X component of Node ID = {postNode.id}:{value}")
