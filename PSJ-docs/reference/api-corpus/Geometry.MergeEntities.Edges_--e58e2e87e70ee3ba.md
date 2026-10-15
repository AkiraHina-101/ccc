# Geometry.MergeEntities.Edges()

Geometry.MergeEntities.Edges()

Description​

Merge all the selected edges into uninterrupted edges.

Syntax​

Geometry.MergeEntities.Edges(...)

Ribbon: Geometry » Merge Entities » Edges

Inputs​

crlEdges​

A List of Cursor specifying the edges to be merged.

This is a required input.

Return Code​

A List of Cursor specifying the merged edges.

Sample Code​

Geometry.Part.Cube()
Geometry.BreakEntity.Edge(crlNodes=[Node(95, 92, 90)])

merged_edges = Geometry.MergeEntities.Edges(crlEdges=[Edge(9, 
                                                           10, 
                                                           11, 
                                                           12, 
                                                           13, 
                                                           14, 
                                                           15, 
                                                           16, 
                                                           17, 
                                                           18, 
                                                           20, 
                                                           28, 
                                                           32, 
                                                           34, 
                                                           35)])

JPT.Debugger(merged_edges)
