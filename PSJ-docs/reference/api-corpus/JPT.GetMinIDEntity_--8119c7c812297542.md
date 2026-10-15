# JPT.GetMinIDEntity()

JPT.GetMinIDEntity()

Description​

Get the minimum ID of the inputted DItemType.

Syntax​

JPT.GetMinIDEntity(DItemType)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

Return Code​

A Integer specifying the maximum ID of the inputted DItemType.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the minimum ID of the created parts
iMinID = JPT.GetMinIDEntity(JPT.DItemType.BODY)
JPT.Debugger(iMinID) # 1
