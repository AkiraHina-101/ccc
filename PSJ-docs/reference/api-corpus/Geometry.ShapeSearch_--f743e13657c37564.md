# Geometry.ShapeSearch()

Geometry.ShapeSearch()

Description​

Search shape in specified parts.

Syntax​

Geometry.ShapeSearch(...)

Macro:

Ribbon: Geometry » ShapeSearch

Inputs​

crlParts​

A List of Cursor specifying the target parts.

This is a required input.

crlRefEdges​

A List of Cursor specifying the reference edges.

The default value is [].

iGroupOption​

An Integer specifying the grouping option.

0: Do not create the Group.

1: Create a group containing all searched results (faces, edges) of all specified shape types for searching in the selected parts.

2: Create separate groups containing the searched results (faces, edges) corresponding to each specified shape type for searching in the selected parts.

The default value is 0.

strGroupName​

A String specifying the name of the group.

The default value is "".

listShapeSearchOptions​

A List of SHAPE_SEARCH_OPTION  specifying the geometry options required for searching.

The default value is SHAPE_SEARCH_OPTION.

bConvexOption​

A Boolean specifying whether to include convex shapes.

The default value is False.

bConcaveOption ​

A Boolean specifying whether to include concave shapes.

The default value is False.

Return Code​

A List of Cursor specifying the entities (face or edge) found.

Sample Code​

# Prepare model
Geometry.Part.Cylinder(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], iPartColor=7434735)

JPT.ClearAllSelection()
# Search planar faces and select.
result=Geometry.ShapeSearch(crlParts=[Part(1, 2)], listShapeSearchOptions=[SHAPE_SEARCH_OPTION(iType=4, bAll=1)])
print(f"There are {len(result)} planar faces.")

JPT.ClearAllSelection()
# Search full cylinder faces and select.
result=Geometry.ShapeSearch(crlParts=[Part(1, 2)], listShapeSearchOptions=[SHAPE_SEARCH_OPTION(iType=8, bAll=1)])
print(f"There are {len(result)} full cylinder faces.")
