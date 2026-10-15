# Connections.Contacts.ADVC.FindContactPairs()

Connections.Contacts.ADVC.FindContactPairs()

Description​

Find contact pairs.

Syntax​

Connections.Contacts.ADVC.FindContactPairs(...)

Ribbon: Connections » Contacts » ADVC » FindContact

Inputs​

crlParts​

A List of Cursor specifying the target parts.

This is the required input.

dFindTolerance​

A Double specifying tolerance to find contact.

The default value is 0.0002.

dTolForTIED​

A Double specifying the distance to set tied.

The default value is 0.1.

Return Code​

A stAdvcParam specifying the parameters of contacts.

Sample Code​

Geometry.Part.Cube(
  iPartColor=6409934)
Geometry.Part.Cube(
  dlOrigin=[0.01, 0.0, 0.0], 
  strName="Cube_2", 
  iPartColor=7463537)
Geometry.Part.Cube(
  dlOrigin=[0.02, 0.0, 0.0], 
  strName="Cube_3", 
  iPartColor=7666683)

cont=Connections.Contacts.ADVC.FindContactPairs(
    crlParts=[Part(1, 2, 3)], 
    dFindTolerance=0.0002, 
    dTolForTIED=0.1)

for c in cont:
    c.stAdvcParam.dClearance=0.1234

Connections.Contacts.ADVC.ContactTable_Advc(cont)
