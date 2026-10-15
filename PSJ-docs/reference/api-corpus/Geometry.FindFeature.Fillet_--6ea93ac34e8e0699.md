# Geometry.FindFeature.Fillet()

Geometry.FindFeature.Fillet()

Description​

Find feature in part by typical description

Syntax​

Geometry.FindFeature.Fillet(crlParts=[], crlFaces=[], dMinAngle=1.0, dMaxAngle=10.0, dMinFaceWidth=1.0, dMaxFaceWidth=10.0, dMinCurveRadius=0.0, dMaxCurveRadius=171, dScale=1.0)

Ribbon: Geometry » FindFeature » Fillet

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dMinAngle​

A Double specifying the minimum angle.

The default value is 1.0.

dMaxAngle​

A Double specifying the maximum angle.

The default value is 10.0.

dMinFaceWidth​

A Double specifying the minimum face width.

The default value is 1.0.

dMaxFaceWidth​

A Double specifying the maximum face width.

The default value is 10.0.

dMinCurveRadius​

A Double specifying the minimum curve radius.

The default value is 0.0.

dMaxCurveRadius​

A Double specifying the maximum curve radius.

The default value is 171.

dScale​

A Double specifying the scale.

The default value is 1.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.FindFeature.Fillet(crlParts=[], crlFaces=[], dMinAngle=1.0, dMaxAngle=10.0, dMinFaceWidth=1.0, dMaxFaceWidth=10.0, dMinCurveRadius=0.0, dMaxCurveRadius=171, dScale=1.0)
