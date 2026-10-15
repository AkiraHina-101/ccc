# JPT.GetAllSelected()

JPT.GetAllSelected()

Description​

Get all the information of all selected entities (Connections, Contacts, Parts, ...).

Syntax​

JPT.GetAllSelected()

Inputs​

This utility function does not require any input value.

Return Code​

A DItemVector object or List of DItem objects containing all the information of all the selected entities.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Select part
listIDParts = [part.id for part in JPT.GetAllParts()]
strIDCursor = " ".join(str(cursor) for cursor in listIDParts)
Home.Find(strSearch=f"{strIDCursor}", strSelectedType="Part")

#Get the information of all selected parts
listSelParts = JPT.GetAllSelected()
JPT.Debugger(listSelParts)
