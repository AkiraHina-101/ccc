# Geometry.BreakEntity.StlPart()

Geometry.BreakEntity.StlPart()

Description​

This method separates the STL parts into multiple bodies.

Syntax​

Geometry.BreakEntity.StlPart(crlParts, iMinNoOfFacet=0, iBreakMethod=0)

Ribbon: Geometry » Break Entity » STL Part

Inputs​

crlParts​

A List of Cursor specifying STL parts to be separated.

This is a required input.

iMinNoOfFacet​

An Integer specifying the minimum number of facets to be considered as an entity.

The default value is 0.

iBreakMethod​

An Integer specifying the break method.

If iBreakMethod=0, separating using the Face based method.

If iBreakMethod=1, separating using the Facet based method. This method separates on a facet basis, ignoring face configurations.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.BreakEntity.StlPart(crlParts=[Part(1)], iMinNoOfFacet=0, iBreakMethod=0)
