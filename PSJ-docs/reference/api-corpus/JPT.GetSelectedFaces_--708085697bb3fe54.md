# JPT.GetSelectedFaces()

JPT.GetSelectedFaces()

Description​

Get all information of the selected faces.

Syntax​

JPT.GetSelectedFaces()

Inputs​

This utility function does not require any input value.

Return Code​

A FaceVector object or List of DFace objects containing all the information of the selected faces.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="20 21 22 23 24", strSelectedType="Face")
JPT.ViewFitToModel()

# Get the information of all selected edges
listSelFaces = JPT.GetSelectedFaces()
JPT.Debugger(listSelFaces)
JPT.Debugger(listSelFaces[2])
