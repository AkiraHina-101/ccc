# JPT.GetAllCustomNotes()

JPT.GetAllCustomNotes()

Description​

Get all the information of all existing custom notes.

Syntax​

JPT.GetAllCustomNotes()

Inputs​

This utility function does not require any input value.

Return Code​

An CustomNoteVector object or List of DCustomNote objects containing all the information of all the existing custom notes.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing edges
listDEdges = JPT.GetAllEdges()
JPT.Debugger(listDEdges)

# Print all the related information of each existing edge in list
for edge in listDEdges:
    JPT.Debugger(edge)
