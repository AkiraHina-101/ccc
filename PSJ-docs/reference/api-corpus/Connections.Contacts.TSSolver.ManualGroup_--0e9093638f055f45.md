# Connections.Contacts.TSSolver.ManualGroup()

Connections.Contacts.TSSolver.ManualGroup()

Description​

Define contact settings between specified groups for TS SunShine solver. Create a group with master and slave surfaces beforehand to define the contact in the contact settings.

Syntax​

Connections.Contacts.TSSolver.ManualGroup(...)

Ribbon: Connections » Contacts » TSSolver » ManualGroup

Inputs​

strName​

A String specifying the name of the contact to be created.

The default value is "ContactTSSolver_1".

tssolverContact​

A list of TSSOLVER_CONTACT specifying the TSSolver contact parameters.

The default value is [].

crplTarget​

A List of Cursor Pair specifying the list or pair of master face group and slave face group.

This is a required input.

crEdit​

A Cursor specifying an existing contact settings item:

If this parameter is used, the specified contact settings item will be modified.

If it is left None, a new contact settings item will be created.

The default value is None.

iColor​

An Integer specifying the contact color.

The default value is 16711680.

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

created_contact = Connections.Contacts.TSSolver.ManualGroup(strName="ContactTSSolver_2", 
                                                            tssolverContact=TSSOLVER_CONTACT(iIshellelemfaceSlave=0, 
                                                                                             iIshellelemfaceMaster=0), 
                                                            crplTarget=[CursorPair(Group(1), 
                                                                                   Group(2))], 
                                                            iMethod=1)

JPT.Debugger(created_contact)
