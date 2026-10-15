# JPT.InverseHideBodies()

JPT.InverseHideBodies()

Description​

Show the part having the inputted ID only.

Syntax​

JPT.InverseHideBodies(partID)

Inputs​

partID​

An Integer specifying the ID of the part which will be shown only.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Geometry.Part.Cube(strName="Cube_15", iPartColor=16579696)

# Show the part with ID = 3 only (Cube_13)
selAllParts = JPT.GetAllParts()
showPart = selAllParts[2].id
JPT.Debugger(selAllParts[2])
JPT.InverseHideBodies(showPart)
