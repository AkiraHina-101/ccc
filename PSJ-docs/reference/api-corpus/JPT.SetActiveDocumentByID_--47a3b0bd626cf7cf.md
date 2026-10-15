# JPT.SetActiveDocumentByID()

JPT.SetActiveDocumentByID()

Description​

Set indicated document in active by using its ID.

Syntax​

JPT.SetActiveDocumentByID(docID, BoolType)

Inputs​

docID​

A String specifying the ID of document to activate.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the selection mode:

True: Activate the indicated document.

False: Do not activate the indicated document.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

doc1 = JPT.CreateNewDocument()
doc2 = JPT.CreateNewDocument()
JPT.SetActiveDocumentByID(doc1.docID, 1)
Geometry.Part.Cube()
JPT.ViewFitToModel()
