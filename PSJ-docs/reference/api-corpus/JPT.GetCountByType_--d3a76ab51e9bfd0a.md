# JPT.GetCountByType()

JPT.GetCountByType()

Description​

Get total number of entities by inputting DItemType.

Syntax​

JPT.GetCountByType(DItemType)

Inputs​

DItemType​

An Enum specifying the DItemType that wants to count the total number.

This is a required input.

Return Code​

An Integer specifying the total number of the inputted type.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Count the total number of bodies existing on the current Jupiter
iPartCount = JPT.GetCountByType(JPT.DItemType.BODY)
print(iPartCount) # 3
