# JPT.CloseDocumentByID()

JPT.CloseDocumentByID()

Description​

Close indicated document by using its ID.

Syntax​

JPT.CloseDocumentByID(docID)

Inputs​

docID​

A String specifying the ID of document to be closed.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
JPT.CreateNewDocument()
for doc in JPT.GetDocumentList():
    if doc.docName == "101_solid":
        JPT.CloseDocumentByID(doc.docID)
