# Meshing.LocalSettings.BoltEdge()

Meshing.LocalSettings.BoltEdge()

Description​

Set the mesh setting for bolt edges (Define the settings before surface mesh creation)

Syntax​

Meshing.LocalSettings.BoltEdge(...)

Macro:

Ribbon: Meshing » LocalSettings » BoltEdge

Inputs​

iCircleDivision​

An Integer specifying number of division in circumferential direction.

The default value is 0.

crlTargets​

A List of Cursor specifying  the target Edges of the local mesh setting.

The default value is [].

Return Code​

A Cursor specifying the created local mesh setting if success, or None if fail.

Sample Code​

Geometry.Part.Cylinder()
Meshing.LocalSettings.BoltEdge(iCircleDivision=8, crlTargets=[Edge(2, 1)])
