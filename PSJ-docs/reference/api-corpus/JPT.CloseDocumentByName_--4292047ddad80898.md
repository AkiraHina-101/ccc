# JPT.CloseDocumentByName()

JPT.CloseDocumentByName()

Description​

Close indicated document by using its name.

Syntax​

JPT.CloseDocumentByName(docName)

Inputs​

docName​

A String specifying the name of document to be closed.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
JPT.CreateNewDocument()
JPT.CloseDocumentByName("101_solid")
