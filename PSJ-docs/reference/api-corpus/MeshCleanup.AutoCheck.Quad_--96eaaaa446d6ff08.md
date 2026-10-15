# MeshCleanup.AutoCheck.Quad()

MeshCleanup.AutoCheck.Quad()

Description​

Correct the surface mesh (QUAD4/QUAD8) by using multiple mesh quality standards.

Syntax​

MeshCleanup.AutoCheck.Quad(...)

Macro:

Ribbon: MeshCleanup » AutoCheck » Quad

Inputs​

crlTargets​

A List of Cursor specifying the targets to check mesh quality. The targets can be part or face.

This is a required input.

bStretchCheck​

A Boolean specifying to check the Stretch quality.

The default value is 0.

bAspectRatioCheck​

A Boolean specifying to check the Aspect Ratio quality.

The default value is 0.

bWarpingCheck​

A Boolean specifying to check the Warping quality.

The default value is 0.

bSkewnessCheck​

A Boolean specifying to check the Skewness quality.

The default value is 0.

bEdgeLengthCheck​

A Boolean specifying to check the Edge Length quality.

The default value is 0.

bAreaCheck​

A Boolean specifying to check the Area quality.

The default value is 0.

bNodeValenceCheck​

A Boolean specifying to check the Node Valence quality.

The default value is 0.

bInteriorAngleCheck​

A Boolean specifying to check Interior Angle quality.

The default value is 0.

bTaperCheck​

A Boolean specifying to check Taper quality.

The default value is 0.

bDuplicateElemsCheck​

A Boolean specifying to check Duplicated Elements.

The default value is 0.

dStretchLimit​

A Double specifying the threshold value of Stretch. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.1.

dAspectRatioLimit​

A Double specifying the threshold value of Aspect Ratio. The elements with a stretch value greater than or equal to the specified value will be detected and displayed on the window.

The default value is 10.

dWarpingLimit​

A Double specifying the threshold value of Warping. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 1.

dSkewnessLimit​

A Double specifying the threshold value of Skewness. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 70.

dEdgeLengthLimit​

A Double specifying the threshold value of Edge Length. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.1.

dAreaLimit​

A Double specifying the threshold value of Area. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.01.

dNodeValenceLimit​

A Double specifying the threshold value of Node Valence. The elements with a stretch value greater than or equal to the specified value will be detected and displayed on the window.

The default value is 10.

dInteriorAngleLimit​

A Double specifying the threshold value of Interior Angle. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 10.

dTaperLimit​

A Double specifying the threshold value of Tapper. The elements with a stretch value greater than or equal to the specified value will be detected and displayed on the window.

The default value is 0.5.

Return Code​

A Tuple specifying the elements's information that violated the mesh quality in order.

Succeeded(1) or Failed(0)

Number of error elements.

A list of ID error elements.

Sample Code​

# Prepare model
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.0001], 
                    ilAxialNodes=[10, 10, 2], 
                    iPartColor=7697908)
JPT.Exec("View Fit To Model()")
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.005, 
                        dMinElemSize=0.005, 
                        dGeomAngle=0.7853981634, 
                        dGradingFactor=0.5, iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                        bFMesher=True, 
                        iThreadNum=16)

# Check mesh quality
result = MeshCleanup.AutoCheck.Quad(crlTargets=[Part(1)], 
                                    bStretchCheck=True, 
                                    bWarpingCheck=True, 
                                    dStretchLimit=0.1, 
                                    dWarpingLimit=0.0174533)
if result[1] >=1:
    print("The number of error elements is " + str(result[1]))
    print("The error elements are " + str(result[2]))
else:
    print("There is no error element")
