# Properties.Composite()

Properties.Composite()

Description​

Define a shell property of 2D composite material.

Syntax​

Properties.Composite(...)

Ribbon: Properties » Composite

Inputs​

strName​

A String specifying the name of the new property.

The default value is "ComMatShell1".

iPropertyColor​

An Integer specifying the color of the new property.

The default value is "".

iFT​

An Integer specifying the Failure Theory for composite materials:

0: No Failure Theory is specified.

1: The Hill theory.

2: The Hoffman theory.

3: The Tsai-Wu theory.

4: The Maximum Strain theory.

The default value is 0.

dGE​

A Double specifying the Structural Damping coefficient.

The default value is DFLT_DBL.

iLAM​

An Integer specifying the Laminate options:

0: Not specified - All plies must be specified and all stiffness terms are developed.

1: "SYM" - Only plies on one side of the laminate centerline are specified. The plies are numbered starting with 1 for the bottom ply. If the laminate contains an odd number of plies, then model the center ply as half the thickness of the actual center ply.

2: "MEM" - All plies must be specified, but only membrane terms (MID1 on the derived PSHELL entry) are computed.

3: "BEND" - All plies must be specified, but only bending terms (MID2 on the derived PSHELL entry) are computed.

4: "SMEAR" - All plies must be specified, stacking sequence is ignored, MID1=MID2 on the derived PSHELL entry and MID3, MID4 and TS/T and 12I/T**3 terms are set to zero.

5: "SMCORE" - Face plies on one side of the laminate and the core are specified to define a laminate that is symmetric about the midplane of the core. The core is specified last. When calculating face sheet stiffness, stacking sequence of the face sheets is ignored.

The default value is 0.

crMaterial​

A Cursor specifying the material will be applied for composite property.

The default value is None.

dNSM​

A Double specifying the non-structural mass per unit length which is a contribution to the model mass from features that have negligible structural stiffness.

The default value is DFLT_DBL.

iPID​

An Integer specifying the property identification number. This number must be unique with respect to all other property identification numbers.

The default value is 0.

dSB​

A Double specifying the allowable shear stress of the bonding material (allowable interlaminar shear stress). Required if iFT is also specified.

The default value is DFLT_DBL.

iSOUT​

An Integer specifying whether to control individual ply stress and strain print or punch output.

0: Not specified - Not control individual ply stress and strain print or punch output

1: NO - Not control individual ply stress and strain print or punch output

2: YES - Control individual ply stress and strain print or punch output

The default value is 0.

dTREF​

A Double specifying the Reference temperature.

The default value is DFLT_DBL.

dZ0​

A Double specifying the laminate offsets.

The default value is DFLT_DBL.

dZOFF​

A Double specifying the amount of offset of the laminate.

The default value is DFLT_DBL.

crlTargets​

A List of Cursor specifying the entities to be applied to the composite property.

The crlTargets and crCompositeProperty arguments are mutually exclusive (one of them must be specified).

The default value is [].

crCompositeProperty​

A Cursor specifying the existing Composite Property.

If this argument is not None, the specified Composite Property will be modified.

Otherwise, a new Composite Property will be created.

The crlTargets and crCompositeProperty arguments are mutually exclusive (one of them must be specified).

The default value is None.

crLocalCS​

A Cursor specifying the local coordinate system used to define the material axis of the element.

It must be specified if the specified iOrientationMethod is 1 (Coordinate System).

The default value is None.

iOrientationMethod​

An Integer specifying method to define the material axis of the element.

0: Theta - Use the dlOrientationVector value.

1: Coordinate System - Use the coordinate system crLocalCS. The X-axis of the coordinate system is projected to the element plane.

The default value is 0.

dlOrientationVector​

A Vector specifying orientation angle of the longitudinal direction of each ply with the material axis of the element.

It must be specified if the specified iOrientationMethod is 0 (Theta).

The default value is [DFLT_DBL, DFLT_DBL, DFLT_DBL].

Return Code​

A Cursor specifying the newly created or the modified Composite Property.

Sample Code​

Geometry.Part.Cube()
Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
Properties.Composite(strName="ComMatShell1", iPropertyColor=16131973, crMaterial=Material(1),
    iPID=1, crlTargets=[Face(26)])
