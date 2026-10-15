# Connections.Contacts.TSSS.FindContactPairs()

Connections.Contacts.TSSS.FindContactPairs()

Description​

Find the contact pairs in model.

Syntax​

Connections.Contacts.TSSS.FindContactPairs(...)

Ribbon: Connections » Contacts » TSSS » ContactTable

Inputs​

crlParts​

A List of Cursor specifying the parts to find contact pairs.

This is a required input.

dFindTolerance​

A Double specifying the gap distance in meters between parts to detect contact pairs.

The default value is 0.001.

dTolForTIED​

A Double specifying the gap distance in meters between parts for tied definition. Among the detected contact pairs, the contact pair candidate that is less than the entered tolerance is automatically defined as the tied definition.

The default value is 0.001.

iSearchArea​

An Integer specifying the search area criteria.
0: Minimum, only faces found with the searching tolerance will take as potential contact pairs

1: Maximum, it will display as a contact pair candidate up to the face that smoothly connects with the searched face

The default value is 1.

bCheckFaceDir​

A Boolean specifying the option used to check face direction.
True: Check the face direction.

False: Does not check the face direction.

The default value is False.

iMasterBasis​

An Integer specifying the contact segment judgment criteria to be the master face of the detected contact pairs.
0: Mesh size, segment group with large element surface area average value

1: Area, segment group with large total area

The default value is 0.

Return Code​

A List of pairs specifying the found contact pairs.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
result = Connections.Contacts.TSSS.FindContactPairs(crlParts=[Part(1, 2, 3)], iSearchArea=0)
JPT.Debugger(result)
