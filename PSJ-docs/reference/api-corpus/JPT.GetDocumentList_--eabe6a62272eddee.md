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
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))
JPT.CreateNewDocument()
# Get information of all displaying documents
docList = JPT.GetDocumentList()
for doc in docList:
    JPT.Debugger(doc)
