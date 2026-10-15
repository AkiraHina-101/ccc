# Properties.Solid()

Properties.Solid()

Description​

Apply Solid property on the selected entities.

Syntax​

Properties.Solid(...)

Macro: Property3DSolid

Ribbon: Properties » Solid

Inputs​

strName​

A String specifying the property name.

The default value is "Solid Property".

iPID​

An Integer specifying the property identification number (ID number).

The default value is 1.

crMaterial​

A Cursor specifying the pre-defined material in the User's Database library for the solid property.

The default value is None.

iCordM​

An Integer specifying the material Coordinate System(CS). In case of there is a user's Coordinate System existed in model and user want to assign that CS, the value will be taken by local CS's ID number.

If iCordM=-2: None of Coordinate System

If iCordM=-1: Element Coordinate System

If iCordM=0: Global Coordinate System

If iCordM=ID: User's Coordinate System by using ID

The default value is 0.

iIN​

An Integer specifying the Integration Network (NASTRAN solver).

If iIN=0: Disable Integration network

If iIN=1: Using the Quadratic function

If iIN=2: Using the Cubic function

If iIN=3: Using the BUBBLE function

The default value is 0.

iOutLoc​

An Integer specifying the Stress output position (NASTRAN solver).

If iOutLoc=0: Disable output location

If iOutLoc=1: Using Stress of a Gaussian Point

If iOutLoc=2: Using Stress at the node

The default value is 0.

iISOP​

An Integer specifying the Integration Schema method (NASTRAN solver).

If iISOP=0: Disable Integration method

If iISOP=1: Using the reduced Shear Integration Schema method

If iISOP=2: Using the standard Iso-parametric Integration Schema method

The default value is 0.

iFLflag​

An Integer specifying the Fluid element flag (NASTRAN solver).

If iFLflag=0: Disable Fluid element

If iFLflag=1: Using a Fluid element

If iFLflag=2: Using the Structural element

The default value is 0.

iModifiedElem​

An Integer specifying the modified element type (ABAQUS solver).

If iModifiedElem=0: Don't use any Modified element (binary 000000)

If iModifiedElem=1: Using the Hybrid element (binary 000001)

If iModifiedElem=2: Using the Non-conforming element (binary 000010)

If iModifiedElem=4: Using the Modified element (binary 000100)

If iModifiedElem=8: Using the Degenerate Integral element (binary 001000)

If iModifiedElem=16: Using the element for Thermal Structural coupling analysis (binary 010000)

If iModifiedElem=32: Using the Acoustic elements (binary 100000)

The default value is 0.

iModifiedElemADVC​

An Integer specifying the modified element type (ADVC solver).

If iModifiedElemADVC=0: Don't use any Modified element (binary 000000)

If iModifiedElemADVC=2: Using the Non-conforming element (binary 000010)

If iModifiedElemADVC=4: Using the Modified element (binary 000100)

If iModifiedElemADVC=8: Using the Degenerate Integral element (binary 001000)

The default value is 0.

bHasDynaRemesh​

A Boolean enable/disable the configuration setting related to LS-Dyna (LS-Dyna Solver).

The default value is False.

dDynaRemeshVal1​

A Double specifying the minimum edge length when the LS-Dyna configuration setting is set as True.

The default value is 0.0.

dDynaRemeshVal2​

A Double specifying the maximum edge length when the LS-Dyna configuration setting is set as True.

The default value is 0.0.

iAbaqusPropHGtype​

An Integer specifying the ABAQUS property Hourglass Control type for element.

If iAbaqusPropHGtype=0: Using Default settings

If iAbaqusPropHGtype=1: Using the Enhanced setting

If iAbaqusPropHGtype=2: Using the Stiffness setting

The default value is 0.

dDispHG​

A Double specifying the displacement hourglass scaling factor. This will become required input when Hourglass Control type is stiffness setting.

The default value is 0.0.

crlTargets​

A List of Cursor specifying the list of Solid target (Part, Solid Element) will be added property.

This is a required input.

crEdit​

A Cursor specifying an existing Solid property setting item. If this parameter is used, the specified Solid property setting item will be modified. If it is left None, a new Solid property setting item will be created.

The default value is None.

iFLG​

An Integer specifying the Duplication checking option. This option is used only for reassigning Solid property for the Part which already had Solid property. The purpose is to let user can control the Duplication could be allowed when creating Solid property for Part or Solid Element.

If iFLG=-1: Disable check duplication option, creating Solid property item without checking duplication in selected Part or Solid Element. This option allow creating multi-duplicated Solid property item for same part

If iFLG=0: Enable check duplication option, the property will be assigned only to bodies that do not have the property assigned yet

If iFLG=1: Enable check duplication option, the Part or Solid element which is already existing Solid property will be changed to new Solid property

The default value is 0.

Return Code​

A Cursor specifying the created solid property.

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
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=16, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

created_prop =  Properties.Solid(strName="Solid Property 1", 
                                 crMaterial=Material(1), 
                                 iCordM=-2, 
                                 dDispHG=DFLT_DBL, 
                                 crlTargets=[Part(1)], 
                                 iFLG=-1)

JPT.Debugger(created_prop)
