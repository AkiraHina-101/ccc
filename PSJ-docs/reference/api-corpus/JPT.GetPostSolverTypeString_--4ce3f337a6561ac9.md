# JPT.GetPostSolverTypeString()

JPT.GetPostSolverTypeString()

Description​

Get solver type of the current importing result.

Syntax​

JPT.GetPostSolverTypeString()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying the name of solver type (Such as Nastran OP2, Nastran HDF5, ADVC, Abaqus, etc).

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

strSolverType = JPT.GetPostSolverTypeString()
JPT.Debugger(strSolverType)
