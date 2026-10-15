# Connections.Contacts.SunShine.ManualFace()

Connections.Contacts.SunShine.ManualFace()

Description​

Define contact settings between specified faces for the TechnoStar Sunshine solver.

Syntax​

Connections.Contacts.SunShine.ManualFace(...)

Ribbon: Connections » Contacts » SunShine » Manual Face

Inputs​

crlMasterFaces​

A List of Cursor specifying the faces to be the master faces.

This is a required input.

crlSlaveFaces​

A List of Cursor specifying the faces to be the slave faces.

This is a required input.

strName​

A String specifying the contact name.

The default value is "ContactSunShine_1".

sunshineContact​

A Struct specifying the Sunshine contact parameters.

The default value is SUNSHINE_CONTACT().

crContactSunShine​

A Cursor specifying an existing SunShine contact setting. If this argument is specified, the specified SunShine contact setting will be modified. If it is left None, a new SunShine contact setting will be created.

The default value is None.

iContactColor​

An Integer specifying the contact-to-display marker color.

The default value is 16711680.

bDesigner​

A Boolean specifying whether to create the sub-group of master and slave faces in Group window.

If bDesigner=True, create a new sub-group named "Contact Faces(SS)" under the parent group with master and slave face groups separately inside.

If bDesigner=False, create two new master and slave face separately group under the parent group.

The default value is False.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube()

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=4803000)

creating_status = Connections.Contacts.SunShine.ManualFace(crlMasterFaces=[Face(24)],
                                                           crlSlaveFaces=[Face(49)],
                                                           strName="ContactSunShine_1", 
                                                           sunshineContact=SUNSHINE_CONTACT(dERROR=0.001, 
                                                                                            dFRIC=0.5,
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL),
                                                           iContactColor=16711680)

JPT.Debugger(creating_status)
