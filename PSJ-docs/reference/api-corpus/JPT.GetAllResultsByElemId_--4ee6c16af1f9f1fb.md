# JPT.GetAllResultsByElemId()

JPT.GetAllResultsByElemId()

Description​

Get all result values of specified Element by ID.

Syntax​

JPT.GetAllResultsByElemId(elementID,breturnBlank)

Inputs​

elementID​

An Integer specifying the ID of Element to be checked the result value.

This is a required input.

bReturnBlank​

A Boolean specifying the option to express the blank value.

The default value is False.

Return Code​

A List specifying all results of Element.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Mises, 2}, \
                            {1, 0, 0, 0, 16, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# Get the all result values of Element ID = 33
valuesElemID = JPT.GetAllResultsByElemId(33)
for data in valuesElemID:
    type, id, value= data
    print(f'Type:{type} ID:{id} Value:{value}')
