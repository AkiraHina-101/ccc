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
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))
JPT.CreateNewDocument()
for doc in JPT.GetDocumentList():
    if doc.docName == "101_solid":
        JPT.CloseDocumentByID(doc.docID)
