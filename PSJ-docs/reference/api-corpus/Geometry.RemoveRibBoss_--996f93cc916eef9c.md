# Geometry.RemoveRibBoss()

Geometry.RemoveRibBoss()

Description​

This method removes Boss or Rib geometry and replaces it with a smooth face.

Syntax​

Geometry.RemoveRibBoss(crlFaces, dGradiation=1.0, iContinuity=1)

Ribbon: Geometry » Remove Rib/Boss

Inputs​

crlFaces​

A List of Cursor specifying the adjacent faces around the Rib or Boss geometry. These faces must be connected to each other.

This is a required input.

dGradiation​

A Double specifying the gradation value. It defines the rate at which the mesh transitions between high mesh density and low mesh density for the new smooth face. Possible values are greater than or equal to 0.5.

The default value is 1.0.

iContinuity​

An Integer specifying the connection continuity factor. It defines the rate at which the smooth shape transition between the bound face and the new smooth face. The possible values that iContinuity can take are 0, 1, and 2.

The default value is 1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(ilAxialNodes=[11, 11, 11])

Geometry.Edge.Line(dllPoints=[[0.01, 0.01, 0.005], [0, 0.01, 0.005]], crlFaces=[Face(22)])

Geometry.Part.Cylinder(dlOrigin=[0.005, 0.01, 0.005], dTopRadius=0.002, dBottomRadius=0.002,
    dHeight=0.003)

Assemble.BooleanEx([Part(1, 2)])

Geometry.RemoveRibBoss(crlFaces=[Face(35, 37)])
