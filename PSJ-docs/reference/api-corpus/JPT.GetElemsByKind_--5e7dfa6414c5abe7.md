# JPT.GetElemsByKind()

JPT.GetElemsByKind()

Description​

Get a List of Elements by inputting their kind (1D, 2D, 3D, etc.).

Syntax​

JPT.GetElemsByKind(ElemKind)

Inputs​

ElemKind​

An Enum specifying the ElemKind of elements in Jupiter.

This is a required input.

Return Code​

An ElemVector object or List of DElem objects containing all the information of the related elements having the element kind is the same as the inputted element kind.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing 2D elements
list2DElems = JPT.GetElemsByKind(JPT.ElemKind.ELEMKIND_2D)
JPT.Debugger(list2DElems)

# Print all the related information of each existing 2D element in list
for elem in list2DElems:
    JPT.Debugger(elem)
