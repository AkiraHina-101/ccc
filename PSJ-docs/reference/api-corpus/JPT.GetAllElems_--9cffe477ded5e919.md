# JPT.GetAllElems()

JPT.GetAllElems()

Description​

Get all the information of all existing elements.

Syntax​

JPT.GetAllElems()

Inputs​

This utility function does not require any input value.

Return Code​

An ElemVector object or List of DElem objects containing all the information of all the existing elements.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing elements
listDElems = JPT.GetAllElems()
JPT.Debugger(listDElems)

# Print all the related information of each existing element in list
for elem in listDElems:
    JPT.Debugger(elem)
