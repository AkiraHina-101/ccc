# Connections.Contacts.TSSS.ManualGroup()

Connections.Contacts.TSSS.ManualGroup()

Description​

This method defines a contact setting between specified groups for TechnoStar SunShine solver.

Syntax​

Connections.Contacts.TSSS.ManualGroup(...)

Ribbon: Connections » Contacts » SunShine » Manual Group

Inputs​

strName​

A String specifying the contact name.

The default value is "ContactTS_SS_1".

tssolverContact​

A SUNSHINE_CONTACT specifying the Sunshine contact parameters.

The default value is SUNSHINE_CONTACT.

crplTarget​

A List of Pairs of Cursor specifying the pair of master and slave groups.

The default value is [].

crEdit​

A Cursor specifying an existing SunShine contact setting. If this argument is specified, the specified SunShine contact setting will be modified. If unspecified, a new SunShine contact setting will be created.

The default value is None.

iColor​

An Integer specifying the contact-to-display marker color.

The default value is 0.

iMethod​

An Integer specifying the method.

The default value is 1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=4803000)

Connections.Contacts.SunShine.ManualFace(crlMasterFaces=[Face(24)], crlSlaveFaces=[Face(49)],
    strName="ContactSunShine_1", sunshineContact=SUNSHINE_CONTACT(dERROR=0.001, dFRIC=0.5,
    dSLIDE=DFLT_DBL, iICOORD=DFLT_INT, dSFACT=DFLT_DBL, dSFACTT=0.5, dCDAMP=DFLT_DBL),
    iContactColor=16711680)

Connections.Contacts.TSSS.ManualGroup(strName="ContactSunShine_2", iColor=16711680,
    tssolverContact=SUNSHINE_CONTACT(dERROR=1e-06, dFRIC=0.5, dSLIDE=DFLT_DBL, iICOORD=DFLT_INT,
    dSFACT=DFLT_DBL, dSFACTT=0.5, dCDAMP=DFLT_DBL), crplTarget=[CursorPair(Group(1), Group(2))])
