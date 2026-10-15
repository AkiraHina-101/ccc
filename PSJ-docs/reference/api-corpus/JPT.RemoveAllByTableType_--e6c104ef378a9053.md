# JPT.RemoveAllByTableType()

JPT.RemoveAllByTableType()

Description​

Remove all the entities relating to the inputted DTableType.

Syntax​

JPT.RemoveAllByTableType(DTableType)

Inputs​

DTableType​

An Enum specifying the DTableType of the entities which will be removed.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=5955674)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5682356)
Geometry.Part.Cube(strName="Cube_3", iPartColor=12237393)
Geometry.Part.Cube(strName="Cube_4", iPartColor=6740326)
Geometry.Part.Cube(strName="Cube_5", iPartColor=7335919)

# Remove all the created parts
JPT.RemoveAllByTableType(JPT.DTableType.DTABLE_BODY)
