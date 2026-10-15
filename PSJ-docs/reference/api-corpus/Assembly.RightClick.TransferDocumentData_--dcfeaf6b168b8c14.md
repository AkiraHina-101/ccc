# Assembly.RightClick.TransferDocumentData()

Assembly.RightClick.TransferDocumentData()

Description​

Transfer data information of entity between documents.

Syntax​

Assembly.RightClick.TransferDocumentData(...)

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

# Create a Cube in document 1: Jupiter1
Geometry.Part.Cube()

# Copy/Transfer Cube into document 2: Jupiter2
result = Assembly.RightClick.TransferDocumentData(strSourceDocTitle="Jupiter1", strDestDocTitle="Jupiter2",
    crlParts=[Part(1)], strlNewPartName=[])

JPT.Debugger(result)
