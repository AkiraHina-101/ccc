# JPT.GetDocumentList()

JPT.GetDocumentList()

Description​

Get information of all displaying documents.

Syntax​

JPT.GetDocumentList()

Inputs​

This utility function does not require any input value.

Return Code​

A List of Document object specifying the information of all displaying documents.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
JPT.CreateNewDocument()
# Get information of all displaying documents
docList = JPT.GetDocumentList()
for doc in docList:
    JPT.Debugger(doc)
