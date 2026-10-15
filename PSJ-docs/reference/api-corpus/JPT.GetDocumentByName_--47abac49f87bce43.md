# JPT.GetDocumentByName()

JPT.GetDocumentByName()

Description​

Get information of an indicated document by using its name.

Syntax​

JPT.GetDocumentByName(docName)

Inputs​

docName​

A String specifying the name of document to get information.

This is a required input.

Return Code​

A Document object specifying the information of document.

Sample Code​

samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
docInfor = JPT.GetDocumentByName("101_solid")
JPT.Debugger(docInfor)
