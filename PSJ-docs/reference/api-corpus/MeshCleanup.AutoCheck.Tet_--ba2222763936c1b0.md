# MeshCleanup.AutoCheck.Tet()

MeshCleanup.AutoCheck.Tet()

Description​

Correct the solid mesh (TET4/TET10) by using multiple mesh quality standard.

Syntax​

MeshCleanup.AutoCheck.Tet(...)

Macro:

Ribbon: MeshCleanup » AutoCheck » Tet

Inputs​

crlTargets​

A List of Cursor specifying the targets to check mesh quality. The targets can only be part.

This is a required input.

bStretchCheck​

A Boolean specifying to check the Stretch quality.

The default value is 0.

bAspectRatioCheck​

A Boolean specifying to check the Aspect Ratio quality.

The default value is 0.

bVolumeCheck​

A Boolean specifying to check the Volume quality.

The default value is 0.

bJacobFactorCheck​

A Boolean specifying to check the Jacobian Factor quality.

The default value is 0.

bTetCollapseCheck​

A Boolean specifying to check the Tet collapse quality.

The default value is 0.

bTetSkewCheck​

A Boolean specifying to check the Tet Skewness quality.

The default value is 0.

dStretchLimit​

A Double specifying the threshold value of Stretch. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.1.

dAspectRatioLimit​

A Double specifying the threshold value of Aspect Ratio. The elements with a stretch value greater than or equal to the specified value will be detected and displayed on the window.

The default value is 10.

dVolumeLimit​

A Double specifying the threshold value of Volume. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.

dJacobFactorLimit​

A Double specifying the threshold value of Jacobian Factor. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.

dTetCollapseLimit​

A Double specifying the threshold value of Tet Collapse. The elements with a stretch value less than or equal to the specified value will be detected and displayed on the window.

The default value is 0.05.

dTetSkewLimit​

A Double specifying the threshold value of Tet Skewness. The elements with a stretch value greater than or equal to the specified value will be detected and displayed on the window.

The default value is 0.9.

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
Meshing.SolidMeshing(crlParts=[Part(1)], 
                    dGradingFactor=1.05, 
                    dStretchLimit=0.1, 
                    iSpeedVsQual=1, 
                    iRegion=1, 
                    bSafeMode=False, 
                    iParallel=16, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

# Check mesh quality
result = MeshCleanup.AutoCheck.Tet(crlTargets=[Part(1)], 
                                    bTetSkewCheck=True, 
                                    dTetSkewLimit=0.9)
if result[1] >=1:
    print("The number of error elements is " + str(result[1]))
    print("The error elements are " + str(result[2]))
else:
    print("There is no error element")
