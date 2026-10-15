# Connections.Contacts.Abaqus.ManualFace()

Connections.Contacts.Abaqus.ManualFace()

Description​

Define contact settings between specified faces for the Abaqus solver.

Syntax​

Connections.Contacts.Abaqus.ManualFace(...)

Ribbon: Connections » Contacts » Abaqus » ManualFace

Inputs​

strName​

A String specifying the contact name.

The default value is "ContactAbaqus_1".

iContactAlgorithm​

An Integer specifying the type of contact connection.

0: Face to Face - Contact between shell or solid element faces and shell or solid element faces.

1: Node to Face - Contact between node and shell or solid element faces.

The default value is 0.

iContactType​

An Integer specifying the behavior type of contact definition. The behavior type of contact definition is one of the following.

0: General Type (Sliding Contact)

1: Tied Type (Shell-Solid contact)

2: All with self Type

The default value is 0.

iAlg​

An Integer specifying the contact setting target entity.

The default value is 0.

dAdjustVal​

A Double specifying the adjustment width of the initial node position.

The default value is 0.0.

dExtensionZone​

A Double specifying the extended area.

The default value is 0.0.

dMaxPenetration​

A Double specifying the maximum penetration distance value.

The default value is 0.0.

iSmallSliding​

An Integer specifying the consideration of small-slip.

0: OFF

1: ON

The default value is 0.

dSmooth​

A Double specifying the smoothing angle.

The default value is 0.0.

iFrictionType​

An Integer specifying the friction characteristics type. The friction characteristics type is one of the following.

0: None

1: General

2: Lagrange

3: Rough

4: Static & Kinetic

The default value is 0.

dFrictionCoef1​

A Double specifying the friction coefficient 1 when Friction type is set as General or Lagrange.

The default value is 0.0.

dFrictionCoef2​

A Double specifying the friction coefficient 2 when Friction type is set as General or Lagrange.

The default value is 0.0.

dShearLimit​

A Double specifying the Shear stress limit when Friction type is set as General or Lagrange.

The default value is 0.0.

dSlipTol​

A Double specifying the maximum allowable elastic slip for surface dimension ratio when Friction type is set as General or Static & Kinetic.

The default value is 0.0.

dStaticFrictionCoef​

A Double specifying the Coefficient of static friction when Friction type is set as Static & Kinetic.

The default value is 0.0.

dKineticFrictionCoef​

A Double specifying the Coefficient of dynamic friction when Friction type is set as Static & Kinetic.

The default value is 0.0.

dDecayCoef​

A Double specifying the Reduction factor when Friction type is set as Static & Kinetic.

The default value is 0.0.

iAdjust​

An Integer specifying the consideration of adjustment.

The default value is 0.

dPositionTol​

A Double specifying the position tolerance value.

The default value is 0.0.

iFormula​

An Integer specifying the contact formulation type.

0: Node to Surface

1: Surface to Surface

The default value is 0.

iTie​

An Integer specifying the fixed conditions and contact pair.

The default value is 0.

iPOCType​

An Integer specifying the Contact thickness of the contact direction behavior, to define the penetration characteristics type.

The default value is 0.

iAllowSeparation​

An Integer specifying the separation option when pressure-overclosure type is set as Hard Contact.

The default value is 0.

dSlope​

A Double specifying the contact stiffness when pressure-overclosure type is set as Linear.

The default value is 0.0.

tshPOCTsheet​

A Table Sheet specifying the table of pressure-Overclosure when pressure-overclosure type is set as Exponential.

The default value is [].

iClearanceType​

An Integer specifying the contact characteristic definition method of heat conduction.

0: None

1: Clearance Dependency

2: Pressure Dependency

3: Clearance & Pressure Dependency

The default value is 0.

iClearanceTypeId​

An Integer specifying the clearance dependency type ID.

The default value is 0.

bTemperatureDependency​

A Boolean enable/disable using temperature dependency data.

The default value is False.

iDependencies​

An Integer specifying number of the field variables.

The default value is 0.

tshCDTsheet​

A Table Sheet specifying the table of clearance dependency.

The default value is [].

iPrsTypeId​

An Integer specifying the pressure dependency type ID.

The default value is 0.

bPrsTemperatureDependency​

A Boolean enable/disable using temperature dependency data.

The default value is False.

iPrsDependencies​

An Integer specifying number of the field variables.

The default value is 0.

tshPrsDTsheet​

A Table Sheet specifying the table of pressure dependency.

The default value is [].

crplTargets​

A Cursor Pair List specifying the list or pair of group master face and group slave face.

The default value is [].

crEdit​

A Cursor specifying an existing contact settings item. If this parameter is used, the specified contact settings item will be modified. If it is left None, a new contact settings item will be created.

The default value is None.

iColor​

An Integer specifying the contact color.

The default value is 0.

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=15132254)
Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0], 
                   strName="Cube_2",
                   iPartColor=6013120)
Geometry.Part.Cube(dlOrigin=[0.011, 0.01, 0.0],
                   strName="Cube_3",
                   iPartColor=5395146)
Tools.Group.CreateGroup(strGroupName="Group1",
                        crlTargets=[Face(73)])
Tools.Group.CreateGroup(strGroupName="Group2",
                        crlTargets=[Face(48)])
Assembly.RightClick.Rename(strNewName="Master",
                           crItem=Group(1))
Assembly.RightClick.Rename(strNewName="Slave",
                           crItem=Group(2))
Meshing.SolidMeshing(crlParts=[Part(1, 2, 3)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_M",
                        crlTargets=[Face(24)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_S",
                        crlTargets=[Face(49)])

# Create face contact (Abaqus)
creating_status = Connections.Contacts.Abaqus.ManualFace(strName="ContactAbaqus_1",
                                                         dAdjustWidth=0.01,
                                                         dExtensionZone=DFLT_DBL,
                                                         dMaxPenetration=DFLT_DBL,
                                                         iSmallSliding=1,
                                                         dSmoothAngle=DFLT_DBL,
                                                         iFrictionType=1,
                                                         dFrictionCoeff1=0.015,
                                                         dFrictionCoeff2=DFLT_DBL,
                                                         dShearStressLimit=DFLT_DBL,
                                                         dSlipTolerance=DFLT_DBL,
                                                         dStaticFrictionCoeff=DFLT_DBL,
                                                         dKineticFrictionCoeff=DFLT_DBL,
                                                         dDecayCoeff=DFLT_DBL,
                                                         bAdjustPosition=True,
                                                         dPositionTolerance=DFLT_DBL,
                                                         dContactStiffness=DFLT_DBL,
                                                         tshPressureOverclosure=[0, 0],
                                                         tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
                                                         tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL],
                                                         crplTargets=[CursorPair(Group(3), Group(4))],
                                                         iContactColor=16711680)

JPT.Debugger(creating_status)
