# Connections.Contacts.MSCNastran.ManualFace()

Connections.Contacts.MSCNastran.ManualFace()

Description​

Define contact settings between specified faces for the MSC Nastran solver.

Syntax​

Connections.Contacts.MSCNastran.ManualFace(...)

Ribbon: Connections » Contacts » MSCNastran » ManualFace

Inputs​

crlMasterFaces​

A List of Cursor specifying the list of faces (Master faces).

This is the require input.

crlSlaveFaces​

A List of Cursor specifying the list of faces (Slave faces).

This is the require input.

strName​

A String specifying the contact name.

The default value is "ContactMSCNastran_1".

iContactAlgorithm​

An Integer specifying the type of contact connection.
0: Face to Face - Contact between shell or solid element faces and shell or solid element faces.

The default value is 0.

iContactType​

An Integer specifying the behavior type of contact definition. The behavior type of contact definition is one of the following.
0: General Type (Sliding Contact)

1: Tied Type (Shell-Solid contact)

2: Tied & Maintain Gap Type

3: Tied & Full moment Type

4: Tied & Full moment & Maintain Gap Type

The default value is 0.

nastranContact​

A NASTRAN_CONTACT specifying the Nastran contact parameters.

The default value is NASTRAN_CONTACT.

crEdit​

A Cursor specifying an existing contact settings item. If this parameter is used, the specified contact settings item will be modified. If it is left None, a new contact settings item will be created.

The default value is None.

iColor​

An Integer specifying the contact color.

The default value is 65280.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=15132254)
Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6013120)
Geometry.Part.Cube(dlOrigin=[0.011, 0.01, 0.0],
                   strName="Cube_3",
                   iPartColor=5395146)
Tools.Group.CreateGroup(strGroupName="Group1",
                        crlTargets=[Face(73)])
Tools.Group.CreateGroup(strGroupName="Group2",
                        crlTargets=[Face(48)])
Assembly.RightClick.Rename(strNewName="Master",
                           crItem=Group(1))
Assembly.RightClick.Rename(strNewName="Slave",
                           crItem=Group(2))
Meshing.SolidMeshing(crlParts=[Part(1, 2, 3)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

creating_status = Connections.Contacts.MSCNastran.ManualFace(crlMasterFaces=[Face(24)],
                                                             crlSlaveFaces=[Face(49)],
                                                             nastranContact=NASTRAN_CONTACT(dRROR=0.0005),
                                                             iColor=16711680)

JPT.Debugger(creating_status)
