# JPT.GetMaxIDEntity()

JPT.GetMaxIDEntity()

Description​

Get the maximum ID of the inputted DItemType.

Syntax​

JPT.GetMaxIDEntity(DItemType)

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

# Get the maximum ID of the created parts
iMaxID = JPT.GetMaxIDEntity(JPT.DItemType.BODY)
JPT.Debugger(iMaxID) # 3
