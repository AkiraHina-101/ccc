# Connections.Contacts.Ansys.ContactShareFace()

Connections.Contacts.Ansys.ContactShareFace()

Description​

Define contact settings for ANSYS by using shared faces.

Syntax​

Connections.Contacts.Ansys.ContactShareFace(...)

Ribbon: Connections » Contacts » Ansys » Contact Share Face

Inputs​

crlShareFaces​

A List of Cursor specifying list of shared faces which are separated (faces with double nodal states are created), and contact pairs are defined between the faces. The crlShareFaces and crContactAnsys arguments are mutually exclusive. One of them must be specified.

The default value is [].

strName​

A String specifying the contact name.

The default value is "ContactAnsys_1".

iBehaviorType​

An Integer specifying the behavior type of contact definition. Possible values are 0 and 1.
0: General Type (Sliding Contact)

1: Shell-Solid Assembly (Original Mesh) Type

The default value is 0.

iContactType​

An Integer specifying the type of contact connection.
0: Face-To-Face - Contact between shell or solid element faces and shell or solid element faces.

The default value is 0.

ansysContact​

An ANSYS_CONTACT specifying the Ansys contact properties.

The default value is ANSYS_CONTACT.

crContactAnsys​

A Cursor specifying an existing Ansys Contact (Contact Separate Face). If this parameter is used, the specified contact settings will be modified. Otherwise, a new contact settings will be created. The crlShareFaces and crContactAnsys arguments are mutually exclusive. One of them must be specified.

The default value is None.

iContactColor​

An Integer specifying the contact color.

The default value is 16711680.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=13064794)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=13948008)

Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[49, 
                                                   24], 
                        dTolerance=0.000222222,
                        iTypeConnectPos=0)

created_contact = Connections.Contacts.Ansys.ContactShareFace(crlShareFaces=[Face(49)], 
                                                              ansysContact=ANSYS_CONTACT(dFricCoef=0.2, 
                                                                                         dPenaStiffness=0.1, 
                                                                                         dPetrTolerance=0.1))

JPT.Debugger(created_contact)
