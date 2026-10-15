# JPT.GetAllFaces()

JPT.GetAllFaces()

Description​

Get all the information of all existing faces.

Syntax​

JPT.GetAllFaces()

Inputs​

This utility function does not require any input value.

Return Code​

A FaceVector object or List of DFace objects containing all the information of all the existing faces.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing faces
listDFaces = JPT.GetAllFaces()
JPT.Debugger(listDFaces)

# Print all the related information of each existing face in list
for face in listDFaces:
    JPT.Debugger(face)
