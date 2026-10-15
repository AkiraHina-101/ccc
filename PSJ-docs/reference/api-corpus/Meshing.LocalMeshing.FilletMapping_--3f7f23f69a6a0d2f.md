# Meshing.LocalMeshing.FilletMapping()

Meshing.LocalMeshing.FilletMapping()

Description​

Select and mesh all the existing fillet faces.

Syntax​

Meshing.LocalMeshing.FilletMapping(...)

Ribbon: Meshing » LocalMeshing » FilletMapping

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

dLayerAngle​

A Double specifying the angle between each fillet layer in degrees.

The default value is 30.

dAxisAspectRatio​

A Double specifying the ratio of the length to the width of a layer.

The default value is 3.

dAxisMinSize​

A Double specifying the minimum size for each dimension of a layer cell, in meter.

The default value is 0.001

bAxisMinSize​

A Boolean specifying whether to use min size criterion or not.

The default value is True.

dAxisMaxSize​

A Double specifying the maximum size for each dimension of a layer cell, in meter.

The default value is 0.003.

bAxisMaxSize​

A Boolean specifying whether to use max size criterion or not.

The default value is True.

iAxisMinMeshCount​

An Integer specifying the minimum node count on each dimension of every fillet faces. If a fillet faces has a dimension whose node count is less than the criterion, map meshing on the face will be skipped.

The default value is 1.

bAxisMinMeshCount​

A Boolean specifying whether to use min mesh count criterion or not.

The default value is True.

iElementType​

An Integer specifying the type 2D element to be created. It can be one of the following:
0: Tri3.

1: Quad4.

The default value is 0.

dSingleLayerLength​

A Double specifying the maximum length of the single layer in meter.

The default value is 0.001.

bSingleLayerLength​

A Boolean specifying whether to use single layer length criterion or not.

The default value is True.

dSingleLayerRadius​

A Double specifying the maximum radius of the single layer in meter.

The default value is 0.001.

bSingleLayerRadius​

A Boolean specifying whether to use single layer radius criterion or not.

The default value is False.

iMinNumLayer​

An Integer specifying the minimum number of layers to be created.

The default value is 3.

bMinNumLayer​

A Boolean specifying whether to use single min number of layers criterion or not.

The default value is True.

bCreateReference=False​

A Boolean specifying whether to create a reference part after meshing or not.

The default value is True.

bRemeshTheEnd​

A Boolean specifying whether to use local remesh for ending position of fillet to fit with surrounding mesh size or not.

The default value is False.

bSkipComplexFace​

A Boolean specifying whether to skip complex fillet faces or not.

The default value is False.

Return Code​

A List of Cursor specifying the meshed fillet faces, or None if failed.

Sample Code​

Geometry.Part.Cube()
Geometry.MakeFillet(crlEdges=[Edge(18, 19, 15)])

fillet_faces = Meshing.LocalMeshing.SelectFillet(crlParts=[Part(1)], 
                                                 crlFaces=[])

fillet_meshing = \
Meshing.LocalMeshing.FilletMapping(crlFaces=[Face(*[int(str(_).split(":")[-1].strip()) 
                                                    for _ in fillet_faces])])

JPT.Debugger(fillet_meshing)
