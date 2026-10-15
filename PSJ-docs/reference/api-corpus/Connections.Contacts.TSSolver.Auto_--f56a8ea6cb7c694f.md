# Connections.Contacts.TSSolver.Auto()

Connections.Contacts.TSSolver.Auto()

Description​

Search and creat contact between the existing parts automatically based on the specified conditions.

Syntax​

Connections.Contacts.TSSolver.Auto(...)

Ribbon: Connections » Contacts » TSSolver » Auto

Inputs​

strlNames​

A List of String specifying the list of the contact names to be created.

This is a required input.

crllMasterFaceTargets​

A List of Cursor specifying the list of master faces.

This is a required input.

crllSlaveFaceTargets​

A List of Cursor specifying the list of slave faces.

This is a required input.

crlContactTypes​

A List of Cursor specifying the list of contact types.

The default value is [1].

dlInterferenceClosures​

A List of Double specifying the list interference closures.

The default value is [1.0].

dlFrictionCoefficients​

A List of Double specifying the list friction coefficients.

The default value is [DFLT_DBL].

blInitialAdjustments​

A Boolean specifying Whether or not using initial adjustments.

The default value is False.

crlColors​

A List of Cursor specifying the list of contact colors.

The default value is 65280.

crlEdit​

A List of Cursor specifying the list of existing contact settings item. 
If this parameter is used, the specified contact settings item will be modified. 

If it is left None, a new contact settings item will be created.

The default value is [].

crlMasterGroups​

A List of Cursor specifying the list of master groups.

The default value is [].

crlSlaveGroups​

A List of Cursor specifying the list of slave groups.

The default value is [].

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=12537679)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6250449)

created_contact = Connections.Contacts.TSSolver.Auto(strlNames=["C1_Cube_1(24)_Cube_2(49)"], 
                                                     crllMasterFaceTargets=[[Face(24)]], 
                                                     crllSlaveFaceTargets=[[Face(49)]],
                                                     crlEdit=[None],
                                                     crlMasterGroups=[None], 
                                                     crlSlaveGroups=[None])

JPT.Debugger(created_contact)
