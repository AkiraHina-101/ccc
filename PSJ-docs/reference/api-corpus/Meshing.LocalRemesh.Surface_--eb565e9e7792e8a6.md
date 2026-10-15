# Meshing.LocalRemesh.Surface()

Meshing.LocalRemesh.Surface()

Description​

Remesh the selected faces.

Syntax​

Meshing.LocalRemesh.Surface(...)

Macro: LocalRemeshTriQuad

Ribbon: Meshing » LocalRemesh » Surface

Inputs​

crlTargets​

A List of Cursor specifying the target for surface remeshing. This target can be Parts, Faces, Edges, or Elements.

This is a required input.

surfaceMesh​

A SURFACE_MESH specifying the mesh parameter.

This is a required input.

bUseSetting​

A Boolean to enable or disable the use of local setting. If this parameter is disabled (False), the existing local mesh settings will not be used.

The default value is True.

bGrading​

A Boolean to enable or disable the gradation of mesh. If enabled (True), surrounding faces will be remeshed together with the selected targets. If disabled (False), only selected targets will be remeshed.

The default value is False.

bFMesher​

A Boolean to enable or disable the use of F-mesher. F-mesher is a mesher to create only Quad4 elements. If surfaceMesh is set to create Tri3 element, this option does not have any effect.

The default value is False.

iOverrideType​

An Integer specifying the mesh pattern type.

0 (IsoMesh): Create isotropic mesh (structured mesh) on selected targets, if applicable.

1 (FreeMesh): Create free mesh (unstructured mesh) on selected targets.

The default value is 1.

bKeepConnection​

A Boolean to enable (True) or disable (False) the keeping of connection (boundary conditions) after meshing.

The default value is False.

bProjCAD​

A Boolean to enable (True) or disable (False) the projection of remeshed targets onto CAD models.

The default value is True.

bIDcheck​

A Boolean to enable or disable ID check when projecting.

bTinyFaceMerge​

A Boolean to enable (True) or disable (False) the merge of tiny faces before remeshing. This option is equivalent to Geometry.MergeEntities.TinyFacesMerge.

The default value is False.

dMinFaceWidth​

A Double specifying the minimum face width. If bTinyFaceMerge is True, this parameter will be used to search for tiny faces.

The default value is 0.

dMaxFaceWidth​

A Double specifying the maximum face width. If bTinyFaceMerge is True, this parameter will be used to search for tiny faces.

The default value is 0.001.

bKeepRemeshEdge​

A Boolean to enable (True) or disable (False) thee keeping of edges created when remeshing. This option only works when selected targets are Elements 2D. If disabled, the selected elements will be separated into new faces, new edges will also be created. If enabled, new faces and edges will not be created.

The default value is False.

iGradingElem​

An Integer specifying the number of adjacent layers to be locally remeshed.

The default value is 0.

Return Code​

A Boolean of True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()

creating_status = Meshing.LocalRemesh.Surface(crlTargets=[Face(26)], 
                                              surfaceMesh=SURFACE_MESH(dAvgElemSize=0.0005,
                                                                       dMaxElemSize=0.001, 
                                                                       dMinElemSize=0.0001, 
                                                                       dGeomAngle=0.7853981853, 
                                                                       iPerformanceMode=1,
                                                                       dAutoMergeTinyFacesAngle=0.5235987902, 
                                                                       bLocalRemesh=True, 
                                                                       iNextEntityOffsetId=8985, 
                                                                       iNextElemOffsetId=2601),
                                              bGrading=True, 
                                              iOverrideType=0)

JPT.Debugger(creating_status)
