# JPT.GetDocumentByID()

JPT.GetDocumentByID()

Description​

Get information of an indicated document by using its ID.

Syntax​

JPT.GetDocumentByID(docID)

Inputs​

docID​

A String specifying the ID of document to get information.

This is a required input.

Return Code​

A Document object specifying the information of document.

Sample Code​

doc = JPT.CreateNewDocument()
docInfor = JPT.GetDocumentByID(doc.docID)
JPT.Debugger(docInfor)
