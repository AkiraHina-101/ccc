# JPT.GetPostSolverType()

JPT.GetPostSolverType()

Description​

Get the result type of the current importing result file.

Syntax​

JPT.GetPostSolverType()

Inputs​

This utility function does not require any input value.

Return Code​

An Enum specifying the Post Job type of importing result.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Get Post Job type
type = JPT.GetPostSolverType()
print(type)
