# Meshing.LocalMeshing.SelectFillet()

Meshing.LocalMeshing.SelectFillet()

Description​

Select all the existing fillet faces based on the selected entities.

Syntax​

Meshing.LocalMeshing.SelectFillet(...)

Ribbon: Meshing » LocalMeshing » SelectFillet

Inputs​

crlParts​

A List of Cursor specifying the list of target parts to search for fillet faces.

The default value is [].

crlFaces​

A List of Cursor specifying the list of target faces to search for fillet faces.

The default value is [].

dMinArcLength​

A Double specifying the minimum length of fillet edge in meter. This is a search criterion.

The default value is 0.0.

dMaxArcLength​

A Double specifying the maximum length of fillet edge in meter. This is a search criterion.

The default value is 0.009.

dMinArcRadius​

A Double specifying the minimum radius of fillet edge in meter. This is a search criterion.

The default value is 0.0.

dMaxArcRadius​

A Double specifying the maximum radius of fillet edge in meter. This is a search criterion.

The default value is 1.0.

bConvex​

A Boolean to enable (True) or disable (False) the search for convex fillet.

The default value is True.

bConcave​

A Boolean to enable (True) or disable (False) the search for concave fillet.

The default value is True.

Return Code​

A List of Cursor specifying the found fillet faces if succeeded, or None if failed.

Sample Code​

Geometry.Part.Cube()
Geometry.MakeFillet(crlEdges=[Edge(18, 19, 15)])

faces = Meshing.LocalMeshing.SelectFillet(crlParts=[Part(1)], 
                                          crlFaces=[])

JPT.Debugger(faces)
