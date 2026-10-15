# Properties.Beam()

Properties.Beam()

Description​

Apply beam property on the selected entities.

Syntax​

Properties.Beam(...)

Ribbon: Properties » Beam

Inputs​

strName​

A String specifying the name of the new property.

The default value is "BEAM1".

iPropertyColor​

An Integer specifying the color of the created property.

crCrossSection​

A Cursor specifying the cross-sectional in the library. The crCrossSection and iShapeDataType arguments are mutually exclusive. One of them must be specified. Two section types are listed as below:
SectionGeneral(): The general cross-sectional shape.

SectionLibrary(): The cross-sectional shape library of Nastran.

The default value is None.

iShapeDataType​

An Integer specifying the shape data type.

The default value is 0.

crMaterial​

A Cursor specifying the material will be applied for Beam.

The default value is None.

dSectionArea​

A Double specifying the area of beam cross-section. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dlSectionOrientation​

A List of Double specifying the orientation of beam cross-section.

The default value is [0,0,0].

dlInertiaMoment​

A List of Double specifying the three components area moments of inertia, expressed in the principal axis of the BEAM. This argument must be specified when the general section is chosen for crCrossSection.

The default value is [0,0,0].

dTorsionalConst​

A Double specifying the torsion constant which is involved in the relationship between angle of twist and applied torque along the axis of the beam. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dNSM​

A Double specifying the nonstructural mass per unit length which is a contribution to the model mass from features that have negligible structural stiffness. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMA​

A Double specifying the nonstructural mass per unit length at end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMB​

A Double specifying the nonstructural mass per unit length at end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMNode1​

A Double specifying y-coordinate of center of gravity of nonstructural mass for end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMNode2​

A Double specifying z-coordinate of center of gravity of nonstructural mass for end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMNode3​

A Double specifying y-coordinate of center of gravity of nonstructural mass for end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNSMNode4​

A Double specifying z-coordinate of center of gravity of nonstructural mass for end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dShearStiffnessFactorK1​

A Double specifying the area factors for shear for plane 1. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dShearStiffnessFactorK2​

A Double specifying the area factors for shear for plane 2. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dShearAreaReliefS1​

A Double specifying the shear relief coefficient due to taper for plane 1. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dShearAreaReliefS2​

A Double specifying the shear relief coefficient due to taper for plane 2. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dWrapCoeff1​

A Double specifying the warping coefficient for end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dWrapCoeff2​

A Double specifying the warping coefficient for end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNA1​

A Double specifying the y-coordinate of neutral axis for end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNA2​

A Double specifying the z-coordinate of neutral axis for end A. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNA3​

A Double specifying the y-coordinate of neutral axis for end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dNA4​

A Double specifying the z-coordinate of neutral axis for end B. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dStressRecoveryCoeffCy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point C at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffCz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point C at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffDy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point D at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffDz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point D at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffEy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point E at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffEz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point E at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffFy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point F at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

dStressRecoveryCoeffFz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point F at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is 0.0.

bPinA1​

A Boolean specifying whether to remove the connection between the grid point and the translation UX of the BEAM at end A.

The default value is False.

bPinA2​

A Boolean specifying whether to remove the connection between the grid point and the translation UY of the BEAM at end A.

The default value is False.

bPinA3​

A Boolean specifying whether to remove the connection between the grid point and the translation UZ of the BEAM at end A.

The default value is False.

bPinA4​

A Boolean specifying whether to remove the connection between the grid point and the rotation RX of the BEAM at end A.

The default value is False.

bPinA5​

A Boolean specifying whether to remove the connection between the grid point and the rotation RY of the BEAM at end A.

The default value is False.

bPinA6​

A Boolean specifying whether to remove the connection between the grid point and the rotation RZ of the BEAM at end A.

The default value is False.

bPinB1​

A Boolean specifying whether to remove the connection between the grid point and the translation UX of the BEAM at end B.

The default value is False.

bPinB2​

A Boolean specifying whether to remove the connection between the grid point and the translation UY of the BEAM at end B.

The default value is False.

bPinB3​

A Boolean specifying whether to remove the connection between the grid point and the translation UZ of the BEAM at end B.

The default value is False.

bPinB4​

A Boolean specifying whether to remove the connection between the grid point and the rotation RX of the BEAM at end B.

The default value is False.

bPinB5​

A Boolean specifying whether to remove the connection between the grid point and the rotation RY of the BEAM at end B.

The default value is False.

bPinB6​

A Boolean specifying whether to remove the connection between the grid point and the rotation RZ of the BEAM at end B.

The default value is False.

dlOffsetA​

A List of Double specifying the offset vector of end point A.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

dlOffsetB​

A List of Double specifying the offset vector of end point B.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

iLengthUnit​

An Integer specifying the local unit as the units of length measurement. Possible values are 0, 1, 2, 3 and 4 that correspond to mm, m, ft, in, and cm.

The default value is 0.

iMassUnit​

An Integer specifying the local unit as the units of mass measurement. Possible values are 0, 1 and 2 that correspond to t, kg, and kgf*s^2/mm.

The default value is 0.

crlTargets​

A List of Cursor specifying the entities to be applied the BEAM property. Possible targets are BEAM, Edge, 1D Element, and Node. The crlTargets and crEdit arguments are mutually exclusive. One of them must be specified.

The default value is [].

crEdit​

A Cursor specifying the existed Beam property to modify it. This option uses only for editing property purpose.

The default value is None.

bTapped​

A Boolean specifying whether the cross-sectional performance should be changed with node position of the beam element.

The default value is False.

dTapArea​

A Double specifying the area of tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dlVecTapInertia​

A Double List specifying the three components area moments of inertia of tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

dTapTorConst​

A Double specifying the torsional constant of tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapNSM​

A Double specifying the nonstructural mass per unit length of tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffCy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point C at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffCz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point C at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffDy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point D at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffDz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point D at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffEy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point E at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffEz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point E at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffFy​

A Double specifying the stress recovery coefficients at the y-coordinate in the BEAM element coordinate system of point F at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

dTapStressRecoveryCoeffFz​

A Double specifying the stress recovery coefficients at the z-coordinate in the BEAM element coordinate system of point F at which stresses are computed for tapered Beam. This argument must be specified when the general section is chosen for bTapped.

The default value is DFLT_DBL.

iIntePtNum​

An Integer specifying the integration points of the Beam element.

The default value is DFLT_INT.

Return Code​

A Cursor specifying the created beam property.

Sample Code​

Geometry.Part.Cube()

Properties.Material.Add("Structural_Steel", 
                        [Density([(DENSITY, 
                                   7.85e-09)]),
                         Elastic([(YOUNGS_MODULUS, 
                                   200000.0), 
                                  (POISSONS_RATIO, 
                                   0.3)])])

Properties.Section.AddGeneral(strName="Circle",
                              iSecGenType=2, 
                              dDsecGensizeT1=0.0002)

created_prop = Properties.Beam(strName="BEAM1",
                               iPropertyColor=3986571, 
                               crCrossSection=SectionGeneral(1), 
                               crMaterial=Material(1), 
                               dSectionArea=1.25664e-07, 
                               dlSectionOrientation=[1.0, 
                                                     0.0, 
                                                     0.0], 
                               dlInertiaMoment=[1.257e-15, 
                                                1.257e-15, 
                                                0.0], 
                               dTorsionalConst=2.513e-15, 
                               dShearStiffnessFactorK1=0.9, 
                               dShearStiffnessFactorK2=0.9, 
                               dStressRecoveryCoeffCy=0.0002, 
                               dStressRecoveryCoeffDz=0.0002, 
                               dStressRecoveryCoeffEy=-0.0002, 
                               dStressRecoveryCoeffFz=-0.0002, 
                               crlTargets=[Edge(18)])

JPT.Debugger(created_prop)
