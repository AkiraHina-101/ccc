# Assembly.RightClick.TransferDocumentData()

Assembly.RightClick.TransferDocumentData()

Description​

Transfer data information of entity between documents.

Syntax​

Assembly.RightClick.TransferDocumentData(...)

Macro: TransferDocumentData

Ribbon: Assembly » Right Click » Copy

Inputs​

strSourceDocTitle​

A String specifying the name of source document.

The is the required input.

strDestDocTitle​

A String specifying the name of destination document. If the destination document does not exist before running this PSJ-Command, it will firsly create a new document with the name used in strDestDocTitle

The is the required input.

crlParts​

A List of Cursor specifying the transformed parts.

The is the required input.

strlNewPartName​

A List of String specifying the new name of transformed parts in the destination document.

The default value is [].

crDestAssemblyInstance​

A Cursor specifying the sub assembly where transformed parts moves.

bEnableCutOperation​

A Boolean specifying cut or paste.

False: cut, True: copy.

Return Code​

A Cursor specifying the newly created parts in destination document.

note

PSJ interpreter will raise error (exception) when it can not find an entity in database (a database query error). With a wrong input argument (document name, part ID) then it can lead to a query error rather than return a failed result.

Sample Code​

# Create a Cube in 1st document.
doc1=JPT.GetActiveDocument()
Geometry.Part.Cube()

#2nd doc is created
doc2=JPT.CreateNewDocument()

# Copy/Transfer Cube into document 2: 
result = Assembly.RightClick.TransferDocumentData(
    strSourceDocTitle=doc1.docName, 
    strDestDocTitle=doc2.docName,
    crlParts=[Part(1)], 
    strlNewPartName=[])

# Check cube in both 1st and 2nd document.
Home.Windows.TileVertical(iMode=1)
Home.Synchronize()
JPT.ViewFitToModel()
