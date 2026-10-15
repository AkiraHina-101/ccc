# JPT.GetAllNodes()

JPT.GetAllNodes()

Description​

Get all the information of all existing nodes.

注記

If this function is executed on a Post document, it may return an incorrect value. If you want to get all Post nodes, please use  GetAllPostNodes.

Syntax​

JPT.GetAllNodes()

Inputs​

This utility function does not require any input value.

Return Code​

A NodeVector object or List of DNode objects containing all the information of all the existing nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing nodes
listDNodes = JPT.GetAllNodes()
JPT.Debugger(listDNodes)

# Print all the related information of each existing node in list
for node in listDNodes:
    JPT.Debugger(node)
