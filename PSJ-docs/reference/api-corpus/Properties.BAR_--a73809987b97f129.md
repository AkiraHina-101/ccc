# Properties.BAR()

Properties.BAR()

Description​

Apply bar property on the selected entities.

Syntax​

Properties.BAR(...)

Macro: Property1DBar

Ribbon: Properties » BAR

Inputs​

strName​

A String specifying the name of the new property.

The default value is "".

iPropertyId​

An Integer specifying the identify number of the created property.

The default value is 1.

iPropertyColor​

An Integer specifying the color of the created property.

crCrossSection​

A Cursor specifying the cross-sectional in the library. The crCrossSection and iShapeDataType arguments are mutually exclusive. One of them must be specified.

The default value is None.

iShapeDataType​

An Integer specifying the shape type from the default list. The crCrossSection and iShapeDataType arguments are mutually exclusive. One of them must be specified.

The default value is 0.

crMaterial​

A Cursor specifying the material will be applied for Bar property.

The default value is None.

dSectionArea​

A Double specifying the area of bar cross-section. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dlSectionOrientation​

A List of Double specifying the orientation of bar cross-section.

This is a required input.

dlInertiaMoment​

A List of Double specifying the three components area moments of inertia, expressed in the principal axis of the bar. This argument must be specified when the general section is chosen for crCrossSection.

The default value is [0.0,0.0,0.0].

dDatadTorConst​

A Double specifying the torsion constant which is involved in the relationship between angle of twist and applied torque along the axis of the bar. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDatadNSM​

A Double specifying the nonstructural mass per unit length which is a contribution to the model mass from features that have negligible structural stiffness. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataShearAreaFactor0​

A Double specifying the area factor for shear for plane 1. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataShearAreaFactor1​

A Double specifying the the area factor for shear for plane 2. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff0​

A Double specifying the stress recovery coefficients at the y-coordinate in the BAR element coordinate system of point C at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff1​

A Double specifying the stress recovery coefficients at the z-coordinate in the BAR element coordinate system of point C at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff2​

A Double specifying the stress recovery coefficients at the y-coordinate in the BAR element coordinate system of point D at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff3​

A Double specifying the stress recovery coefficients at the z-coordinate in the BAR element coordinate system of point D at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff4​

A Double specifying the stress recovery coefficients at the y-coordinate in the BAR element coordinate system of point E at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff5​

A Double specifying the stress recovery coefficients at the z-coordinate in the BAR element coordinate system of point E at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff6​

A Double specifying the stress recovery coefficients at the y-coordinate in the BAR element coordinate system of point F at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

dDataStressRecoveryCoeff7​

A Double specifying the stress recovery coefficients at the z-coordinate in the BAR element coordinate system of point F at which stresses are computed. This argument must be specified when the general section is chosen for crCrossSection.

The default value is DFLT_DBL.

bDataPinA0​

A Boolean specifying whether to remove the connection between the grid point and the translation UX of the bar at end A.

The default value is False.

bDataPinA1​

A Boolean specifying whether to remove the connection between the grid point and the translation UY of the bar at end A.

The default value is False.

bDataPinA2​

A Boolean specifying whether to remove the connection between the grid point and the translation UZ of the bar at end A.

The default value is False.

bDataPinA3​

A Boolean specifying whether to remove the connection between the grid point and the rotation RX of the bar at end A.

The default value is False.

bDataPinA4​

A Boolean specifying whether to remove the connection between the grid point and the rotation RY of the bar at end A.

The default value is False.

bDataPinA5​

A Boolean specifying whether to remove the connection between the grid point and the rotation RZ of the bar at end A.

The default value is False.

bDataPinB0​

A Boolean specifying whether to remove the connection between the grid point and the translation UX of the bar at end B.

The default value is False.

bDataPinB1​

A Boolean specifying whether to remove the connection between the grid point and the translation UY of the bar at end B.

The default value is False.

bDataPinB2​

A Boolean specifying whether to remove the connection between the grid point and the translation UZ of the bar at end B.

The default value is False.

bDataPinB3​

A Boolean specifying whether to remove the connection between the grid point and the rotation RX of the bar at end B.

The default value is False.

bDataPinB4​

A Boolean specifying whether to remove the connection between the grid point and the rotation RY of the bar at end B.

The default value is False.

bDataPinB5​

A Boolean specifying whether to remove the connection between the grid point and the rotation RZ of the bar at end B.

The default value is False.

dlDataOffset0​

A List of Double specifying the offset vector of end point A.

The default value is [DFLT_DBL, DFLT_DBL, DFLT_DBL].

dlDataOffset1​

A List of Double specifying the offset vector of end point B.

The default value is [DFLT_DBL, DFLT_DBL, DFLT_DBL].

iLocalLengthUnit​

An Integer specifying the local unit as the units of length measurement. Possible values are 0, 1, 2, 3 and 4 that correspond to mm, m, ft, in, and cm.

The default value is 0.

iLocalMassUnit​

An Integer specifying the local unit as the units of mass measurement. Possible values are 0, 1 and 2 that correspond to t, kg, and kgf*s^2/mm.

The default value is 0.

crlTargets​

A List of Cursor specifying the entities to be applied the Bar property. Possible targets are Bar Part, Edge, and 1D Element. The crlTargets and crEdit arguments are mutually exclusive. One of them must be specified.

The default value is [].

crEdit​

A Cursor specifying the existing Bar property. If this argument is not None, the specified Bar property will be modified. Otherwise, a new Bar property will be created. The crlTargets and crEdit arguments are mutually exclusive. One of them must be specified.

The default value is None.

Return Code​

A Cursor specifying the created bar property.

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

created_prop = Properties.BAR(strName="BAR2", 
                              iPropertyId=2, 
                              iPropertyColor=15383527, 
                              crCrossSection=SectionGeneral(1), 
                              crMaterial=Material(1), 
                              dSectionArea=1.25664e-07, 
                              dlSectionOrientation=[1.0, 0.0, 0.0], 
                              dlInertiaMoment=[1.257e-15, 1.257e-15, 0.0], 
                              dTorionalConst=2.513e-15, 
                              dShearAreaFactorY=0.9, 
                              dShearAreaFactorZ=0.9, 
                              dStressRecoveryCoeffCy=0.0002, 
                              dStressRecoveryCoeffCz=0.0, 
                              dStressRecoveryCoeffDy=0.0, 
                              dStressRecoveryCoeffDz=0.0002, 
                              dStressRecoveryCoeffEy=-0.0002, 
                              dStressRecoveryCoeffEz=0.0, 
                              dStressRecoveryCoeffFy=0.0, 
                              dStressRecoveryCoeffFz=-0.0002, 
                              crlTargets=[Edge(19)])

JPT.Debugger(created_prop)
