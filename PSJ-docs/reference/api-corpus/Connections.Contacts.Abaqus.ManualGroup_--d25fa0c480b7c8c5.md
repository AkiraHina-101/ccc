# Connections.Contacts.Abaqus.ManualGroup()

Connections.Contacts.Abaqus.ManualGroup()

Description​

Define the contact set between the specified group for Abaqus. Create a group with master and slave surfaces beforehand to define the contact in the contact settings.

Syntax​

Connections.Contacts.Abaqus.ManualGroup(...)

Ribbon: Connections » Contacts » Abaqus » Manual Group

Inputs​

strName​

A String specifying the new Abaqus Contact name.

The default value is "ContactAbaqus_1".

iContactType​

An Integer specifying the behavior type of contact definition. The behavior type of contact definition is one of the following:

0: General (Sliding Contact)

1: Tied (Shell-Solid contact)

2: All with self - Automatic contact detection

The default value is 0.

iContactAlgorithm​

An Integer specifying the contact setting target entity.

0: Face to Face - Contact between shell or solid element faces and shell or solid element faces.

1: Node to Face - Contact between node and shell or solid element faces.

The default value is 0.

dAdjustWidth​

A Double specifying a value to adjust the initial positions of the surfaces specified. This is required when the iTied parameter is used with ON value. This argument is used only when iContactType=0.

The default value is 0.0.

dExtensionZone​

A Double specifying a value that is equal to a fraction of the end segment or facet edge length by which Abaqus extends the master surface to avoid numerical round-off errors associated with contact modeling. The value given must lie between 0.0 and 0.2. This parameter affects only node-to-surface contact. This argument is used only when iContactType=0.

The default value is 0.0.

dMaxPenetration​

A Double specifying the maximum distance by which a point on the slave surface must penetrate the master surface before Abaqus abandons the current increment and tries again with a smaller increment. This parameter does not apply to contact pairs that use the finite-sliding, surface-to-surface contact formulation. This argument is used only when iContactType=0.

The default value is 0.0.

iSmallSliding​

An Integer specifying whether to use the small-sliding contact formulation. This parameter is not allowed with self-contact. This argument is used only when iContactType=0.

0: OFF

1: ON

The default value is 0.

dSmoothAngle​

A Double specifying the degree of smoothing used for element-based master surfaces in the finite-sliding, node-to-surface contact formulation. The value given must lie between 0.0 and 0.5. This parameter does not affect contact pairs with analytical rigid surfaces or contact formulations other than the finite-sliding, node-to-surface contact formulation. This argument is used only when iContactType=0.

The default value is 0.0.

iFrictionType​

An Integer specifying the friction characteristics type. This argument is used only when iContactType=0.

0: None

1: General

2: Lagrange

3: Rough

4: Static & Kinetic

The default value is 0.

dFrictionCoeff1​

A Double specifying the first friction coefficient to be defined in terms of slip rate. This argument is used only when iFrictionType=1 or iFrictionType=2.

The default value is 0.0.

dFrictionCoeff2​

A Double specifying the second friction coefficient to be defined in terms of slip rate. This argument is used only when iFrictionType=1 or iFrictionType=2.

The default value is 0.0.

dShearStressLimit​

A Double specifying an optional equivalent shear stress limit, so that regardless of the magnitude of the contact pressure stress, sliding will occur if the magnitude of the equivalent shear stress reaches this value. A value of zero is not allowed. This argument is used only when iFrictionType=1 or iFrictionType=2.

The default value is 0.0.

dSlipTolerance​

A Double specifying the maximum allowable elastic slip for surface dimension ratio. This argument is used only when iFrictionType=1 or iFrictionType=4.

The default value is 0.0.

dStaticFrictionCoeff​

A Double specifying the static friction coefficient. This argument is used only when iFrictionType=4.

The default value is 0.0.

dKineticFrictionCoeff​

A Double specifying the dynamic friction coefficient. This argument is used only when iFrictionType=4.

The default value is 0.0.

dDecayCoeff​

A Double specifying the decay coefficient. This argument is used only when iFrictionType=4.

The default value is 0.0.

bAdjustPosition​

An Integer specifying whether to adjust the position of surfaces in the contact pair. This argument is used only when iContactType=1.

The default value is False.

dPositionTolerance​

A Double specifying the tolerance of position of surfaces used for adjustment. This argument is used only when bAdjustPosition=1.

The default value is 0.0.

iFormulationType​

An Integer specifying how Abaqus generates the contact constraint coefficients.  This argument is used only when iContactType=0.

0: Node to Surface

1: Surface to Surface

The default value is 0.

iTied​

An Integer specifying whether the surfaces in the contact pair are to be tied together for the duration of the analysis. This argument is used only when iContactType=0.

0: Not specified - Not want to tie the surfaces together.

1: ON - Tie the surfaces together.

The default value is 0.

iPressureOverclosureType​

An Integer specifying a contact pressure-overclosure relationship.

0: Hard Contact - Pressure-overclosure relationship without physical softening.

1: Exponential - Exponential pressure-overclosure relationship.

2: Linear - Linear pressure-overclosure relationship.

3: Tabular - Piecewise linear pressure-overclosure relationship in tabular form.

4: None

The default value is 0.

bAllowSeparation​

An Integer specifying whether to allow separation of the two surfaces once contact has been established. This argument is used when iPressureOverclosureType=0.

The default value is False.

dContactStiffness​

A Double specifying the slope of the pressure-overclosure curve. This value must be positive and is required when iPressureOverclosureType=2.

The default value is 0.0.

tshPressureOverclosure​

A Table Sheet specifying the tabular data of Pressure-Overclosure used for exponential pressure-overclosure relationship. This argument must be specified when iPressureOverclosureType=1 or iPressureOverclosureType=3.

The default value is [].

iThermalConductanceDef​

An Integer specifying the contact characteristic definition method of heat conduction.

0: None

1: Clearance Dependency

2: Pressure Dependency

3: Clearance & Pressure Dependency

The default value is 0.

bClearanceTemperatureDependency​

A Boolean specifying whether the tabular data have Temperature-Dependent property.

The default value is False.

iClearanceDependencies​

An Integer specifying the number of field variables in the data table. This argument must be specified when iThermalConductanceDef=1 or iThermalConductanceDef=3.

The default value is 0.

tshClearanceData​

A Table Sheet specifying the tabular data of clearance dependency.

The default value is [].

bPressureTemperatureDependency​

A Boolean enable/disable using temperature dependency data.

The default value is False.

iPressureDependencies​

An Integer specifying number of the field variables.

The default value is 0.

tshPressureData​

A Table Sheet specifying the table of pressure dependency.

The default value is [].

crplTargets​

A List of Pair of Cursor specifying the list or pair of group master face and group slave face. The crplTargets and crContactAbaqus arguments are mutually exclusive. One of them must be specified.

The default value is [].

crContactAbaqus​

A Cursor specifying an existing Abaqus Contact (Manual Group). If this parameter is used, the specified contact settings will be modified. Otherwise, a new contact settings will be created. The crplTargets and crContactAbaqus arguments are mutually exclusive. One of them must be specified.

The default value is None.

iContactColor​

An Integer specifying the contact color.

The default value is 0.

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

created_contact = Connections.Contacts.Abaqus.ManualGroup(strName="ContactAbaqus_1", 
                                                          dAdjustWidth=DFLT_DBL,
                                                          dExtensionZone=DFLT_DBL, 
                                                          dMaxPenetration=DFLT_DBL, 
                                                          iSmallSliding=1,
                                                          dSmoothAngle=DFLT_DBL,
                                                          iFrictionType=1, 
                                                          dFrictionCoeff1=DFLT_DBL, 
                                                          dFrictionCoeff2=DFLT_DBL, 
                                                          dShearStressLimit=DFLT_DBL,
                                                          dSlipTolerance=DFLT_DBL, 
                                                          dStaticFrictionCoeff=DFLT_DBL, 
                                                          dKineticFrictionCoeff=DFLT_DBL,
                                                          dDecayCoeff=DFLT_DBL, 
                                                          bAdjustPosition=1, 
                                                          dPositionTolerance=DFLT_DBL, 
                                                          iFormulationType=1, 
                                                          iTied=1,
                                                          iPressureOverclosureType=1, 
                                                          dContactStiffness=DFLT_DBL, 
                                                          tshPressureOverclosure=[0, 
                                                                                  0],
                                                          iThermalConductanceDef=3, 
                                                          tshClearanceData=[1, 
                                                                            2, 
                                                                            DFLT_DBL, 
                                                                            DFLT_DBL],
                                                          tshPressureData=[1, 
                                                                          2, 
                                                                          DFLT_DBL, 
                                                                          DFLT_DBL], 
                                                          crplTargets=[CursorPair(Group(1), 
                                                                                  Group(2))],
                                                          iContactColor=16711680)

JPT.Debugger(created_contact)
