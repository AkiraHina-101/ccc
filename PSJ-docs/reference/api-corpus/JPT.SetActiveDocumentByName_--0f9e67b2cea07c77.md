# JPT.SetActiveDocumentByName()

JPT.SetActiveDocumentByName()

Description​

Set indicated document in active by using its name.

Syntax​

JPT.SetActiveDocumentByName(docName, BoolType)

Inputs​

docName​

A String specifying the name of document to activate.

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
doc3 = JPT.CreateNewDocument()
JPT.SetActiveDocumentByName(doc2.docName,1)
Geometry.Part.Cube()
JPT.ViewFitToModel()
print("Created a Cube in " + str(doc2.docName) + " document")
