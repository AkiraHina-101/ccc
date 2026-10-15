# ACModeling.Create.Convex()

ACModeling.Create.Convex()

Description​

Create Convex In Boundary

Syntax​

ACModeling.Create.Convex(...)

Ribbon: ACModeling » Create » Convex

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

dMeshSize​

A Double specifying the mesh size.

The default value is 0.005.

dOffset​

A Double specifying the offset.

The default value is 0.02.

dRadius​

A Double specifying the radius.

The default value is 0.02.

iDAxisGround​

An Integer specifying the axis ground.

The default value is 0.

dScale​

A Double specifying the scale.

The default value is 0.001.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

ACModeling.Create.Convex(crlParts=[], dMeshSize=0.005, dOffset=0.02, dRadius=0.02, iDAxisGround=0, dScale=0.001)
