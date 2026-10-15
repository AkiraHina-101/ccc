# JPT.GetAllCustomNoteCollections()

JPT.GetAllCustomNoteCollections()

Description​

Get all the information of all existing custom note collections.

Syntax​

JPT.GetAllCustomNoteCollections()

Inputs​

This utility function does not require any input value.

Return Code​

An EdgeVector object or List of DEdge objects containing all the information of all the existing edges.

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
