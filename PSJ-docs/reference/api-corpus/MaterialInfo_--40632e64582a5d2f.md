# MaterialInfo()

MaterialInfo()

Description​

Get the information in the materials

Syntax​

MaterialInfo(String MatName,String Info Type)

Inputs​

1. String​

Material Name

2. String​

Info Type (DENSITY or YOUNGMODULUES or POISSONRATIO)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MaterialInfo("Structural_Steel","DENSITY")

or

MaterialInfo("Structural_Steel","YOUNGMODULUES")
