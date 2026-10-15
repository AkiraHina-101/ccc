# Properties.Cohesive()

Properties.Cohesive()

Description​

Create the property 3d Cohesive for solid element.

Syntax​

Properties.Cohesive(...)

Macro: Prop3DCohesive

Ribbon: Properties » Cohesive

Inputs​

strName​

A String specifying the name of the new property.

This is a required input.

crMaterial​

A Cursor specifying the material will be applied for cohesive property.

This is a required input.

iResponse​

An Integer specifying the response characteristics.
0: Traction Separation.

1: Continuum.

2: Gasket.

This is a required input.

bSpecifyThick​

A Boolean specifying the initial thickness.
False: Geometry - Calculated from the coordinate values of the node.

True: Specified - Specified by user input.

This is a required input.

dInitialThick​

A Double specifying the initial thickness value when bSpecifyThick is false.

This is a required input.

crlTargets​

A List of Cursor specifying the entities to be applied the composite property. The crlTargets and crEdit arguments are mutually exclusive. One of them must be specified

This is a required input.

crEdit​

A Cursor specifying the existing cohesive property. If this argument is not None, the specified cohesive property will be modified. Otherwise, a new cohesive property will be created. The crlTargets and crEdit arguments are mutually exclusive. One of them must be specified.

The default value is None.

iFLG​

An Integer specifying the Duplication checking option. This option is used only for reassigning cohesive property for the Part which already had cohesive property. The purpose is to let user can control the Duplication could be allowed when creating cohesive property for Part or Element.
-1: Disable check duplication option, creating cohesive property item without checking duplication in selected Part or Element. This option allow creating multi-duplicated cohesive property item for same part

0: Enable check duplication option, the property will be assigned only to bodies that do not have the property assigned yet

1: Enable check duplication option, the Part or element which is already existing cohesive property will be changed to new cohesive property

The default value is 0.

iId​

An Integer specifying the property identification number. This number must be unique with respect to all other property identification numbers.

The default value is 0.

iSolverType​

An Integer specifying the solver type.
0: ABAQUS.

1: ADVC.

The default value is 0.

iADVCResponseType​

An Integer specifying the ADVC response type.
0: Continuum.

1: Continuum2.

The default value is 0.

iADVCStackDir​

An Integer specifying the ADVC stack direction.
0: blank.

1: 0.

2: 1.

3: 2.

The default value is 0.

iEnableADVCThickness​

An Integer specifying whether or not enable ADVC thickness.

The default value is 0.

dADVCThickness​

A Double specifying the ADVC thickness when enable ADVC thickness.

The default value is DFLT_DBL.

Return Code​

A Cursor specifying the created cohesive property.

Sample Code​

Geometry.Part.Cube()

Properties.Material.Add("Structural_Steel", 
                        [Density([(DENSITY, 
                                   7.85e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 
                                  200000.0), 
                                 (POISSONS_RATIO, 
                                  0.3)])])

Meshing.SolidMeshing(crlParts=[Part(1)], 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=16, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

created_prop = Properties.Cohesive(strName="Cohensive Property 1", 
                                   iPropertyColor=13708224, 
                                   crMaterial=Material(1), 
                                   iResponse=0, 
                                   bSpecifyThick=False, 
                                   dInitialThick=DFLT_DBL, 
                                   crlTargets=[Part(1)], 
                                   iFLG=-1, 
                                   iId=2)

JPT.Debugger(created_prop)
