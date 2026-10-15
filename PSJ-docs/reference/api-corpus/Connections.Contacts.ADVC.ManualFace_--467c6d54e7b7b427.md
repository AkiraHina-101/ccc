# Connections.Contacts.ADVC.ManualFace()

Connections.Contacts.ADVC.ManualFace()

Description​

Define contact settings between specified faces for the ADVC solver.

Syntax​

Connections.Contacts.ADVC.ManualFace(...)

Ribbon: Connections » Contacts » ADVC » ManualFace

Inputs​

crlMasterFaces​

A List of Cursor specifying the master faces.

This is the required input.

crlSlaveFaces​

A List of Cursor specifying the slave faces.

This is the required input.

strName​

A String specifying the contact name.

The default value is "ContactADVC".

iContactType​

An Integer specifying the behavior type of the contact definition. The behavior type of contact definition is one of the following.
0: General Type (Sliding Contact)

1: Tied Type (Shell-Solid contact)

The default value is 0.

iSlidingType​

An Integer specifying the sliding type.
0: Blank.

1: Finite sliding.

2: Small sliding.

3: Not sliding.

The default value is 0.

iInitialState​

An Integer specifying the initial contact state.
0: Blank.

1: Auto - Auto-detect.

2: Open - Start analysis from the non-contact state

3: Close - Start analysis from the contact state .

The default value is 0.

dInitialStateTol​

A Double specifying the the tolerance value to determine the initial contact state.

The default value is DFLT_DBL.

dKineticFrictionCoef​

A Double specifying the dynamic coefficient of friction.

The default value is DFLT_DBL.

dExponentialCoef​

A Double specifying the exponential damping coefficient.

The default value is DFLT_DBL.

iBehavior​

An Integer specifying the the presence or absence of contact.
0: Separation - Remove the contact restraint when the tensile force is generated.

1: No Separation - Binding on all of the contact pairs that were found at the beginning of the contact search.

The default value is 0.

dClearance​

A Double specifying the clearance amount.

The default value is DFLT_DBL.

iAdjustToClearance​

An Integer specifying whether or not avoid the collapse element in accordance with node movement by Adjust function. This argument is active when iSlidingType=0 or iSlidingType=2.
0: Blank.

1: Yes.

2: No.

The default value is 0.

dInterference​

A Double specifying the interference.

The default value is DFLT_DBL.

iAdjustToInterference​

An Integer specifying whether or not adjust to interference. This argument is active when iSlidingType=1 or iSlidingType=3.
0: Blank.

1: Yes.

2: No.

The default value is 0.

iAutoShrink​

An Integer specifying the presence or absence of penetration elimination.
0: Blank.

1: Yes.

2: No.

The default value is 0.

iAdjust​

An Integer specifying the whether or not move the slave node on the master surface so that the clearance goes to zero.
0: Blank.

1: Yes - Move all of the slave node.

2: Value - Defines the distance to enable the node movement.

The default value is 0.

dAdjustValue​

A Double specifying the distance to enable the node movement.

The default value is DFLT_DBL.

dFrictionCoef​

A Double specifying the coefficient of static friction.

The default value is DFLT_DBL.

dMaxShear​

A Double specifying the maximum shear stress.

The default value is DFLT_DBL.

dElasticSlip​

A Double specifying the allowable amount of slip.

The default value is DFLT_DBL.

dSlipTolerance​

A Double specifying the allowable slip tolerance.

The default value is DFLT_DBL.

dSearchWidth​

A Double specifying the inside and outside determination parameter in the direction of the contact surface.

The default value is DFLT_DBL.

dSearchGap​

A Double specifying the normal direction search distance for the gap surface.

The default value is DFLT_DBL.

dSearchDepth​

A Double specifying the the normal direction search distance for the penetration surface.

The default value is DFLT_DBL.

dCriticalPenetration​

A Double specifying the critical penetration amount.

The default value is DFLT_DBL.

iEstimationImpactTime​

An Integer specifying the contact pairs using prediction of collision and release time.
0: Blank.

1: Yes.

2: No.

The default value is 0.

iFormula​

An Integer specifying the contact formulation type.
0: Blank.

1: Node to Segment: Node - Face contact

2: Segment to Segment: Face - Face contact.

The default value is 0.

iConstraintType​

An Integer specifying the contact constraint type.
0: Blank.

1: Lagrange - Lagrange undetermined multiplier method.

2: Penalty - Penalty method.

The default value is 0.

iThermalDataType​

An Integer specifying the heat transfer coefficient of clearance dependency.
0: Blank.

1: Clearance Dependency - Define the heat transfer coefficient of the clearance dependency.

2: Conductivity - Coefficient of heat transfer.

3: Clearance - Clearance

The default value is 0.

iTypeId​

An Integer specifying the type ID.
0: CLEARANCE_DEPENDENCY.

1: PRESSURE_DEPENDENCY.

The default value is 0.

bTemperatureDependency​

A Boolean specifying whether or not using temperature dependency data .

The default value is False.

iNumDependencies​

An Integer specifying the number of dependencies.

The default value is 0.

tshTableClearance​

A Table Sheet specifying the table of clearance dependency.

The default value is [].

bStabilized​

A Boolean specifying whether or not stabilization parameter is defined.

The default value is 0.

iStabilizeType​

An Integer specifying the type of contact stabilization coefficient.
0: Blank.

1: Stiffness - Stiffness ratio.

2: Area - Area ratio.

The default value is 0.

dResidualFactor​

A Double specifying the residual factor used to define the correction coefficient C1.

The default value is DFLT_DBL.

dEffectiveDist​

A Double specifying the effective distance that is used to define the correction coefficient C2.

The default value is DFLT_DBL.

dCN​

A Double specifying the normal direction stabilization coefficient.

The default value is DFLT_DBL.

dCT​

A Double specifying the tangential direction stabilization coefficient.

The default value is DFLT_DBL.

crlClearances​

A List of Cursor specifying the list of clearances data.

The default value is [].

crContactADVC​

A Cursor specifying an existing contact settings item. If this parameter is used, the specified contact settings item will be modified. If it is left None, a new contact settings item will be created.

The default value is None.

dSearchAngle​

A Double specifying the search angle of normal vector of the master/slave surface

The default value is DFLT_DBL.

iConstraintTypeExplicit​

An Integer specifying the contact constraint type in the explicit dynamic analysis.
0: Blank.

1: Kinematic: Constraint method.

2: Penalty: Penalty method.

The default value is 0.

dPenaltyFact​

A Double specifying the the penalty scale factor.

The default value is DFLT_DBL.

dPenaltyFactExplicit​

A Double specifying the penalty scale factor in the explicit dynamic analysis.

The default value is DFLT_DBL.

iColor​

An Integer specifying the contact color.

The default value is 16711680.

iAlgorithm​

An Integer specifying the contact setting target entity.
0: Face to Face

The default value is 0.

iMethod​

An Integer specifying the method type.
0: MANUAL_FACE.

1: MANUAL_GROUP.

2: BY_GROUP_MATRIX.

3: SHARE_FACE.

4: AUTO_SETTING.

The default value is 0.

bPressureTemperatureDependency​

A Boolean specifying whether or not using pressure temperature dependency data .

The default value is False.

iPressureDependencies​

An Integer specifying the number of pressure dependencies.

The default value is 0.

tshPressureData​

A Table Sheet specifying the table of pressure dependency.

The default value is [].

Return Code​

A Cursor specifying the created contact.

Sample Code​

Geometry.Part.Cube(iPartColor=12537679)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6250449)

created_contact = Connections.Contacts.ADVC.ManualFace(crlMasterFaces=[Face(24)], 
                                                       crlSlaveFaces=[Face(49)], 
                                                       strName="ContactADVC1", 
                                                       iInitialState=1, 
                                                       dInitialStateTol=1.0, 
                                                       dKineticFrictionCoef=1.0, 
                                                       dExponentialCoef=1.0, 
                                                       iBehavior=1, 
                                                       iAdjustToClearance=2, 
                                                       dInterference=2.0, 
                                                       iAdjustToInterference=1, 
                                                       iAdjust=2, 
                                                       dFrictionCoef=1.0, 
                                                       dMaxShear=1.0, 
                                                       dElasticSlip=1.0, 
                                                       dSlipTolerance=1.0, 
                                                       dSearchWidth=1.0, 
                                                       dSearchGap=1.0, 
                                                       dSearchDepth=1.0, 
                                                       dCriticalPenetration=1.0, 
                                                       iFormula=1, 
                                                       iThermalDataType=2, 
                                                       iTypeId=1, 
                                                       tshTableClearance=[1, 
                                                                          2, 
                                                                          0, 
                                                                          0], 
                                                       bStabilized=True, 
                                                       iStabilizeType=2, 
                                                       dSearchAngle=1.0, 
                                                       iConstraintTypeExplicit=2, 
                                                       dPenaltyFact=1.0, 
                                                       dPenaltyFactExplicit=1.0, 
                                                       tshPressureData=[1, 
                                                                        2, 
                                                                        0, 
                                                                        0])

JPT.Debugger(created_contact)
