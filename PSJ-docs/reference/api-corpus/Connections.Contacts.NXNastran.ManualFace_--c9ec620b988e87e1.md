# Connections.Contacts.NXNastran.ManualFace()

Connections.Contacts.NXNastran.ManualFace()

Description​

Define contact settings between specified faces for the NX Nastran solver.

Syntax​

Connections.Contacts.NXNastran.ManualFace(...)

Ribbon: Connections » Contacts » NX Nastran » Manual Face

Inputs​

crlFaceMasters​

A List of Cursor specifying the faces to be the master faces.

This is a required input.

crlFaceSlaves​

A List of Cursor specifying the faces to be the slave faces.

This is a required input.

strName​

A String specifying the contact name.

The default value is "ContactNXNastran_1".

iContactType​

An Integer specifying the behavior type of contact definition.
If iContactType=0, sliding contact.

If iContactType=1, tied contact.

The default value is 0.

iContactAlgorithm​

An Integer specifying the type of contact connection.
If iContactAlgorithm=0, contact between shell or solid element faces and shell or solid element faces.

The default value is 0.

dNormalPenaltyFactor​

A Double specifying the penalty factor for the normal direction. This argument is to be used if iContactType=0.

The default value is 10.

dTangentialPenaltyFactor​

A Double specifying the penalty factor for the tangential direction. This argument is to be used if iContactType=0.

The default value is 1.

dForceConvergenceTol​

A Double designating the Contact Force convergence tolerance. This argument is to be used if iContactType=0.

The default value is 0.01.

dMaxForceIteration​

A Double designating the maximum number of iterations for a force (inner) loop. This argument is to be used if iContactType=0.

The default value is 10.

dMaxStatusIteration​

A Double designating the maximum number of iterations for a status (outer) loop. This argument is to be used if iContactType=0.

The default value is 20.

dNumberOfChange​

A Double specifying the allowable number of contact changes. This argument is to be used if iContactType=0.

The default value is 0.02.

dMinContactPercentage​

A Double specifying the minimum contact set percentage. This argument is to be used if iContactType=0.

The default value is 100.

iShellThickness​

An Integer specifying whether to include shell thickness for plate elements. The gap between connection regions will be independent of plate element thickness if this option is turned off. This argument is to be used if iContactType=0.
If iShellThickness=0, include half shell thickness as surface offset.

If iShellThickness=1, does not include thickness offset.

The default value is 0.

iContactStatus​

An Integer specifying the flag to indicate if the contact status for a specific sub-case is to start from the final status of the previous subcase. This argument is to be used if iContactType=0.
If iContactStatus=0, starts from previous subcase.

If iContactStatus=1, starts from initial state.

The default value is 0.

iInitGapOrPenetration​

An Integer specifying how Nastran handles initial gap or penetration of the generated contact elements. This setting is particularly useful if some of your elements unintentionally penetrate each other and you do not wish to modify or rebuild your model. This argument is to be used if iContactType=0.
If iInitGapOrPenetration=0, use the value calculated from the grid coordinates.

If iInitGapOrPenetration=1, sets the penetration to zero for all contact elements.

If iInitGapOrPenetration=2, sets the both penetration and gap to zero for all contact elements.

The default value is 0.

iRegionRefine​

An Integer specifying whether or not the source region is refined. This argument is to be used if iContactType=0.
If iRegionRefine=0, refines the source region based on target surface definition.

If iRegionRefine=1, does not refine the source region based on target surface definition.

The default value is 0.

iEvaluateOrder​

An Integer specifying the number of “Linear Contact Points” for a single element on the source region.
If iEvaluateOrder=0, lowest order of points on source region.

If iEvaluateOrder=1, medium order of points on source region.

If iEvaluateOrder=2, highest order of points on source region.

The default value is 1.

dMinSearchDist​

A Double specifying the minimum distance for searching the contact elements. This argument is to be used if iContactType=0.

The default value is 0.

dMaxSearchDist​

A Double specifying the maximum distance for searching the contact elements. This argument is to be used if iContactType=0.

The default value is 0.01.

dFrictionCoeff​

A Double specifying the static coefficient of friction for the contact pair. This argument is to be used if iContactType=0.

The default value is 0.

dSearchDist​

A Double specifying the search range. This argument is to be used if iContactType=1.

The default value is 0.

dPenaltyFactor​

A Double specifying the penalty proportional coefficient. This argument is to be used if iContactType=1.

The default value is 0.

iShellZOffset​

An Integer specifying whether the Z-Offset on shell elements should be included in the contact analysis.
If iShellZOffset=0, Z offset of shells is included as surface offset.

If iShellZOffset=1, Z offset of shells is NOT included as surface offset.

The default value is 0.

iContactColor​

An Integer specifying the contact-to-display marker color.

The default value is 0.

crContactNXNastran​

A Cursor specifying an existing contact setting (NX Nastran). If this parameter is used, the specified contact setting (NX Nastran) will be modified. Whe the default value is used, a new contact setting (NX Nastran) will be created.

The default value is None.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=4962231)

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2", 
                   iPartColor=4803000)

creating_status = Connections.Contacts.NXNastran.ManualFace(crlFaceMasters=[Face(24)], 
                                                            crlFaceSlaves=[Face(49)],
                                                            dSearchDist=10.0, 
                                                            dPenaltyFactor=1.0, 
                                                            iContactColor=16711680)

JPT.Debugger(creating_status)
