# Connections.Contacts.MSCNastran.ManualGroup()

Connections.Contacts.MSCNastran.ManualGroup()

Description​

Define contact settings between specified groups for MSC Nastran solver. Create a group with master and slave surfaces beforehand to define the contact in the contact settings.

Syntax​

Connections.Contacts.MSCNastran.ManualGroup(...)

Macro: ContactMSCNastran

Ribbon: Connections » Contacts » MSCNastran » ManualGroup

Inputs​

strName​

A String specifying the name of the contact to be created.

The default value is "ContactMSCNastran_1".

nastranContact​

A NASTRAN_CONTACT specifying the Nastran contact parameters.

The default value is NASTRAN_CONTACT.

crplTarget​

A Cursor Pair List specifying the list or pair of master face group and slave face group.

This is a required input.

crEdit​

A Cursor specifying an existing contact settings item.

If this parameter is used, the specified contact settings item will be modified.

If it is left None, a new contact settings item will be created.

The default value is None.

iColor​

An Integer specifying the contact color.

The default value is 65280.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=12537679)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6250449)

Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_M", 
                        crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_S", 
                        crlTargets=[Face(24)])

created_contact = Connections.Contacts.MSCNastran.ManualGroup(strName="ContactMSCNastran_1", 
                                                              nastranContact=NASTRAN_CONTACT(dRROR=0.0005), 
                                                              crplTarget=[CursorPair(Group(1), 
                                                                                     Group(2))], 
                                                              iColor=16711680)

JPT.Debugger(created_contact)
