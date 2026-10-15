# Properties.Shell()

Properties.Shell()

Description​

Apply Shell property on the selected entities.

Syntax​

Properties.Shell(...)

Ribbon: Properties » Shell

Inputs​

strName​

A String specifying the name of the new property.

The default value is "Shell Property".

iPID​

An Integer specifying the property identification number (ID number).

The default value is 1.

crMatMembrane​

A Cursor specifying the material for membrane behavior.

The default value is None.

crMatBend​

A Cursor specifying the material for bending behavior.

The default value is None.

crMatShear​

A Cursor specifying the material for lateral shear behavior.

The default value is None.

crMatCoupl​

A Cursor specifying the material for coupled film-bending behavior.

The default value is None.

dMatOrient1​

A Double specifying the theta angle 1 when material orientation is defined by angle.

The default value is 0.0.

dThickness​

A Double specifying the thickness of element in millimeters.

This is a required input.

dBendStiff​

A Double specifying the bending stiffness parameter.

The default value is 0.0.

dThickRatio​

A Double specifying the thickness ratio of the lateral shear stiffness.

The default value is 0.5.

dNSM​

A Double specifying the Non-Structural Mass which is a contribution to the model mass from features that have negligible structural stiffness.

The default value is 0.0.

dFiberDist1​

A Double specifying the Fiber distances 1 for stress computation from the reference plane.

The default value is 0.0.

dFiberDist2​

A Double specifying the Fiber distances 2 for stress computation from the reference plane.

The default value is 0.0.

dPlateOff​

A Double specifying the offset value from the reference plane.

The default value is 0.0.

iItgPts​

An Integer specifying the integral number of shell elements.

The default value is 0.

iMatOrientType​

An Integer specifying the material orientation type (Angle - 0 or Coordinate system - 1).

The default value is 0.

crLocalCS​

A Cursor specifying the Local coordinate system when material orientation is defined by Coordinate system.
The X axis of the coordinate system is projected to the element plane.

The default value is None.

crlTargets​

A List of Cursor specifying the list of Shell target (Shell Part, Face, 2D Element).

This is a required input.

crEdit​

A Cursor specifying an existing Shell property setting item. If this parameter is used, the specified Shell property setting item will be modified. If it is left None, a new Shell property setting item will be created.

The default value is None.

iDuplicateOpt​

An Integer specifying the duplicate option. When the property is already assigned to some of the selected bodies, this value = 6 means the existing property will be changed. This value = 7 or 2 means the property will be assigned only to bodies that do not have the property assigned yet.

The default value is 0.

Return Code​

A Cursor specifying the created shell property.

Sample Code​

Geometry.Part.Cube()
Properties.Material.Add("Structural_Steel",
                        [Density([(DENSITY,
                                   7.85e-09)]),
                         Elastic([(YOUNGS_MODULUS,
                                   200000.0),
                                  (POISSONS_RATIO,
                                   0.3)])])

created_prop = Properties.Shell(crMatMembrane=Material(1),
                                crMatBend=Material(1),
                                crMatShear=Material(1),
                                dMatOrient1=DFLT_DBL,
                                dThickness=0.005,
                                dThickRatio=DFLT_DBL,
                                crlTargets=[Face(26)])

JPT.Debugger(created_prop)
