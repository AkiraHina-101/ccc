# Connections.Contacts.CheckPattern()

Connections.Contacts.CheckPattern()

Description​

Check the mesh pattern on the selected faces. The matched/unmatched mesh pattern between selected entities will be shown based on the selected option.

Syntax​

Connections.Contacts.CheckPattern(...)

Ribbon: Connections » Contacts » Check Pattern

Inputs​

crlParts​

A List of Cursor specifying the parts to be checked.

This is a required input.

bShowMismatch​

A Boolean specifying whether to display the part where the mesh pattern does not matches.

The default value is False.

bShowMatch​

A Boolean specifying whether to display the part where the mesh pattern matches.

The default value is True.

dTolerance​

A Double specifying the distance between faces to detect the mesh pattern.

The default value is 0.01.

Return Code​

A Boolean specifying whether the mesh is coincide or not:

True: The mesh pattern between the selected entities is matched.

False: The mesh pattern between the selected entities isn't match.

Sample Code​

Geometry.Part.Cube(iPartColor=12276667)

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=14511581)

Connections.Contacts.NXNastran.ManualFace(crlFaceMasters=[Face(24)],
                                          crlFaceSlaves=[Face(49)],
                                          dSearchDist=10.0,
                                          dPenaltyFactor=1.0,
                                          iContactColor=16711680)

checking_status = Connections.Contacts.CheckPattern(crlParts=[Part(1, 2)])

JPT.Debugger(checking_status)
