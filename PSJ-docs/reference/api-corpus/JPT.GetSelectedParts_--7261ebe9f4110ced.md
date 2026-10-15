# JPT.GetSelectedParts()

JPT.GetSelectedParts()

Description​

Get all information of the selected parts.

Syntax​

JPT.GetSelectedParts()

Inputs​

This utility function does not require any input value.

Return Code​

A BodyVector object or List of DBody objects containing all the information of the selected parts.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="5 6 7 8", strSelectedType="Part")
JPT.ViewFitToModel()

# Get the information of all selected parts
listSelParts = JPT.GetSelectedParts()
JPT.Debugger(listSelParts)
JPT.Debugger(listSelParts[2])
