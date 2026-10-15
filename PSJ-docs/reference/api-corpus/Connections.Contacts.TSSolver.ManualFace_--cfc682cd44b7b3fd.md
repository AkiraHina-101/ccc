# Connections.Contacts.TSSolver.ManualFace()

Connections.Contacts.TSSolver.ManualFace()

Description​

Define contact settings between specified faces for the TS solver.

Syntax​

Connections.Contacts.TSSolver.ManualFace(...)

Ribbon: Connections » Contacts » TSSolver » ManualFace

Inputs​

strName​

A String specifying the name of the contact to be created.

The default value is "ContactTSSolver_1".

tssolverContact​

A List of TSSOLVER_CONTACT specifying the TSSolver contact parameters.

The default value is TSSOLVER_CONTACT.

crplTarget​

A List of Cursor Pair specifying the list or pair of master face group and slave face group.

This is a required input.

crEdit​

A Cursor specifying an existing contact settings item.

If this parameter is used, the specified contact settings item will be modified.

If it is left None, a new contact settings item will be created.

The default value is None.

iColor​

An Integer specifying the contact color.

The default value is 16711680.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.015, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)

Tools.Group.CreateGroup(strGroupName="ContactTSSolver_1_Manual_Face_M", 
                        crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="ContactTSSolver_1_Manual_Face_S", 
                        crlTargets=[Face(24)])

created_contact = Connections.Contacts.TSSolver.ManualFace(tssolverContact=TSSOLVER_CONTACT(iIshellelemfaceSlave=0, 
                                                                                            iIshellelemfaceMaster=0), 
                                                           crplTarget=[CursorPair(Group(1), 
                                                                                  Group(2))])

JPT.Debugger(created_contact)
