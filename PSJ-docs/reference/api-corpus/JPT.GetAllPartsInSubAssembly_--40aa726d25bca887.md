# JPT.GetAllPartsInSubAssembly()

JPT.GetAllPartsInSubAssembly()

Description​

Get all the information of all parts under the inputted sub-assembly.

Syntax​

JPT.GetAllPartsInSubAssembly(subAssem)

Inputs​

subAssem​

A DItem object specifying the inputted sub-assembly.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects specifying the parts belonging to the inputted sub-assembly.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=15426917)
Geometry.Part.Cube(strName="Cube_2", iPartColor=13390932)
Geometry.Part.Cube(strName="Cube_3", iPartColor=16448103)
Geometry.Part.Cube(strName="Cube_4", iPartColor=13619046)
Geometry.Part.Cube(strName="Cube_5", iPartColor=7861111)
JPT.ViewFitToModel()
Assembly.RightClick.AddSubAssembly()

# Copy all parts to the created Subassembly
currentDoc = JPT.GetActiveDocument()
Assembly.RightClick.TransferDocumentData(strSourceDocTitle=currentDoc.docName, 
                                        strDestDocTitle=currentDoc.docName, 
                                        crlParts=[Part(part.id) for part in JPT.GetAllParts()], 
                                        strlNewPartName=[], 
                                        crDestAssemblyInstance=Inst(1))

# Get the information of all parts belonging to the inputted sub-assembly
listPartsInSubAssembly = JPT.GetAllPartsInSubAssembly(JPT.FindSubAssemblyByID(1))
JPT.Debugger(listPartsInSubAssembly)
