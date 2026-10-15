# Connections.Contacts.NXNastran.ManualGroup()

Connections.Contacts.NXNastran.ManualGroup()

Description​

Define contact settings between specified groups for the NX solver.

Syntax​

Connections.Contacts.NXNastran.ManualGroup(...)

Ribbon: Connections » Contacts » NXNastran » ManualGroup

Inputs​

crFaceMaster​

A Cursor specifying the group of faces to be the master faces.

This is a required input.

crFaceSlave​

A Cursor specifying the group of faces to be the slave faces.

This is a required input.

strName​

A String specifying the contact name.

The default value is "ContactNXNastran_1".

iContactType​

An Integer specifying the behavior type of the contact definition. The behavior type of contact definition is one of the following.

0: General contact (Sliding contact).

1: Tied contact.

The default value is 0.

iContactAlg​

An Integer specifying the type of contact connection.

0: Face to Face - Contact between shell or solid element faces and shell or solid element faces.

The default value is 0.

dNormalPenaltyFactor​

A Double specifying the penalty factor for the normal direction. This argument is available to be used if iContactType=0.

The default value is 10.

dTangentialPenaltyFactor​

A Double specifying the penalty factor for the tangential direction. This argument is available to be used if iContactType=0.

The default value is 1.

dForceConvergenceTol​

A Double designating the Contact Force convergence tolerance. This argument is available to be used if iContactType=0.

The default value is 0.01.

dMaxForceIteration​

A Double designating the maximum number of iterations for a force (inner) loop. This argument is available to be used if iContactType=0.

The default value is 10.

dMaxStatusIteration​

A Double designating the maximum number of iterations for a status (outer) loop. This argument is available to be used if iContactType=0.

The default value is 20.

dNumberOfChange​

A Double specifying the allowable number of contact changes. This argument is available to be used if iContactType=0.

The default value is 0.02.

dMinContactPercentage​

A Double specifying the minimum contact set percentage. This argument is available to be used if iContactType=0.

The default value is 100.

iShellThickness​

An Integer specifying whether to include shell thickness for plate elements. The gap between connection regions will be independent of plate element thickness if this option is turned off. This argument is available to be used if iContactType=0.

0: Includes half shell thickness as surface offset.

1: Does not include thickness offset.

The default value is 0.

iContactStatus​

An Integer specifying the flag to indicate if the contact status for a specific sub-case is to start from the final status of the previous subcase. This argument is available to be used if iContactType=0.

0: Starts from previous subcase.

1: Starts from initial state.

The default value is 0.

iInitGapOrPenetration​

An Integer specifying how Nastran handles initial gap or penetration of the generated contact elements. This setting is particularly useful if some of your elements unintentionally penetrate each other and you do not wish to modify or rebuild your model. This argument is available to be used if iContactType=0.

0: Uses the value calculated from the grid coordinates.

1: Sets the penetration to zero for all contact elements.

2: Sets the both penetration and gap to zero for all contact elements.

The default value is 0.

iRegionRefine​

An Integer specifying whether or not the source region is refined. This argument is available to be used if iContactType=0.

0: Refines the source region based on target surface definition.

1: Does not refine the source region based on target surface definition.

The default value is 0.

iEvaluateOrder​

An Integer specifying the number of “Linear Contact Points” for a single element on the source region.

0: Lowest order of points on source region.

1: Medium order of points on source region.

2: Highest order of points on source region.

The default value is 1.

dMinSearchDist​

A Double specifying the minimum distance for searching the contact elements. This argument is available to be used if iContactType=0.

The default value is 0.

dMaxSearchDist​

A Double specifying the maximum distance for searching the contact elements. This argument is available to be used if iContactType=0.

The default value is 0.01.

dFrictionCoef​

A Double specifying the static coefficient of friction for the contact pair. This argument is available to be used if iContactType=0.

The default value is 0.

dSearchDist​

A Double specifying the search range. This argument is available to be used if iContactType=1.

The default value is 0.

dPenaltyFactor​

A Double specifying the penalty proportional coefficient. This argument is available to be used if iContactType=1.

The default value is 0.

iShellZOffset​

An Integer specifying whether the Z-Offset on shell elements should be included in the contact analysis.

0: Z offset of shells is included as surface offset.

1: Z offset of shells is NOT included as surface offset.

The default value is 0.

iContactColor​

An Integer specifying the contact-to-display marker color.

The default value is 0.

crContactNXNastran​

A Cursor specifying an existing contact setting (NX Nastran). If this parameter is used, the specified contact setting (NX Nastran) will be modified. When the default value is used, a new contact setting (NX Nastran) will be created.

The default value is None.

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

created_contact = Connections.Contacts.NXNastran.ManualGroup(crFaceMaster=Group(1), 
                                                             crFaceSlave=Group(2), 
                                                             dSearchDist=10.0, 
                                                             dPenatlyFactor=1.0, 
                                                             iColor=16711680, 
                                                             iMethod=1)

JPT.Debugger(created_contact)
