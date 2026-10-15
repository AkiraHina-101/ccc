# JPT.GetAllParts()

JPT.GetAllParts()

Description​

Get all the information of all existing parts.

Syntax​

JPT.GetAllParts()

Inputs​

This utility function does not require any input value.

Return Code​

A BodyVector object or List of DBody objects containing all the information of all the existing parts.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of all existing parts
listDBodies = JPT.GetAllParts()
JPT.Debugger(listDBodies)

# Print all the related information of each existing part in list
for part in listDBodies:
    JPT.Debugger(part)
