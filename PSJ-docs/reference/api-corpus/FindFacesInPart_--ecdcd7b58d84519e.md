# FindFacesInPart()

FindFacesInPart()

Description​

Find Faces in a Part.

Syntax​

FindFacesInPart(Cursor crTargetPart, string strTargetPartString)

Inputs​

1. Cursor​

Target part cursor (3:Part ID)

2. String​

Finding Target(MaxXFACE,MinXFACE,MaxYFACE,MinYFACE,MaxZFACE,MinZFACE)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

JPT.Exec('FindFacesInPart(3:3, "MaxZFACE")')
