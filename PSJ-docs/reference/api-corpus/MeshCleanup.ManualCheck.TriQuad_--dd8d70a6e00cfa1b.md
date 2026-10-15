# MeshCleanup.ManualCheck.TriQuad()

MeshCleanup.ManualCheck.TriQuad()

Description​

Correct the surface mesh (TRI3/TRI6/QUAD4/QUAD8) according to the selected quality standard.

Syntax​

MeshCleanup.ManualCheck.TriQuad(...)

Macro:

Ribbon: MeshCleanup » ManualCheck » TriQuad

Inputs​

crlTargets​

A List of Cursor specifying the targets to check mesh quality. The targets can be part, face or 2D element.

This is a required input.

iElemQualityType​

An Integer specifying the standard method used to check mesh quality.

0: Stretch

1: Aspect Ratio

2: Edge Length

3: Area

4: Node Valence

5: Interior Angle

6: Unstable

7: Time Step (LS-Dyna)

8: Time Step (Abaqus)

This is a required input.

iCheckConditionTri​

An Integer specifying the inequality sign for the threshold value of TRI element.

If iElemQualityType = 0: The default value is 0 (Less than and equal).

If iElemQualityType = 1: The default value is 2 (Greater than and equal).

If iElemQualityType = 2: The default value is 0 (Less than and equal).

If iElemQualityType = 3: The default value is 0 (Less than and equal).

If iElemQualityType = 4: The default value is 2 (Greater than and equal).

If iElemQualityType = 5: The default value is 0 (Less than and equal).

If iElemQualityType = 6: The default value is 0 (Less than and equal).

If iElemQualityType = 7: The default value is 0 (Less than and equal).

If iElemQualityType = 8: The default value is 0 (Less than and equal).

dLimitValueTri​

A Double specifying the threshold value will be used to detect and display the TRI elements violated the specified mesh quality standard.

If iElemQualityType = 0: The default value is 0.1.

If iElemQualityType = 1: The default value is 10.0.

If iElemQualityType = 2: The default value is 0.1.

If iElemQualityType = 3: The default value is 0.01.

If iElemQualityType = 4: The default value is 10.0.

If iElemQualityType = 5: The default value is 10.0.

If iElemQualityType = 5: The default value is 1.0.

If iElemQualityType = 7: The default value is 9.9E-06.

If iElemQualityType = 8: The default value is 1.0E-10.

dSafetyFactorTri​

A Double specifying the safety factor value of TRI elements to be displayed. This argument is used when iElementQualityType = 7, or 8.

The default value is 1.0.

iCheckConditionQuad​

An Integer specifying the inequality sign for the threshold value of QUAD element.

If iElemQualityType = 0: The default value is 0 (Less than and equal).

If iElemQualityType = 1: The default value is 2 (Greater than and equal).

If iElemQualityType = 2: The default value is 0 (Less than and equal).

If iElemQualityType = 3: The default value is 0 (Less than and equal).

If iElemQualityType = 4: The default value is 2 (Greater than and equal).

If iElemQualityType = 5: The default value is 0 (Less than and equal).

If iElemQualityType = 6: The default value is 0 (Less than and equal).

If iElemQualityType = 7: The default value is 0 (Less than and equal).

If iElemQualityType = 8: The default value is 0 (Less than and equal).

dLimitValueQuad​

A Double specifying the threshold value will be used to detect and display the QUAD elements violated the specified mesh quality standard

If iElemQualityType = 0: The default value is 0.1.

If iElemQualityType = 1: The default value is 10.0.

If iElemQualityType = 2: The default value is 0.1.

If iElemQualityType = 3: The default value is 0.01.

If iElemQualityType = 4: The default value is 10.0.

If iElemQualityType = 5: The default value is 10.0.

If iElemQualityType = 5: The default value is 1.0.

If iElemQualityType = 7: The default value is 9.9E-06.

If iElemQualityType = 8: The default value is 1.0E-10.

dSafetyFactorQuad​

A Double specifying the safety factor value of QUAD elements to be displayed. This argument is used when iElementQualityType = 7, or 8.

The default value is 1.0.

bIncludeDiagonalQuad​

A Boolean specifying to include diagonal line for QUAD. This argument is used when iElementQualityType = 7 (Time Step (LS-Dyna)).

The default value is True.

iNonPrimary​

An Integer specifying the non primary.

The default value is 0.

Return Code​

A Tuple specifying 8 values of mesh quality check in order.

Succeeded(1) or Failed(0)

Cutoff value (Minimum) (Tri check)

Cutoff value (Maximum) (Tri check)

Cutoff value (Average) (Tri check)

Number of measured elements (Tri check)

Number of error elements (Tri check)

A list of ID error elements (Tri check)

A list of error element edges (Tri check)

Cutoff value (Minimum) (Quad check)

Cutoff value (Maximum) (Quad check)

Cutoff value (Average) (Quad check)

Number of measured elements (Quad check)

Number of error elements (Quad check)

A list of ID error elements (Quad check)

A list of error element edges (Quad check)

Sample Code​

# Prepare model
Geometry.Part.Trapezoid(dlLength=[0.01, 0.001, 0.01], 
                        dTopXLength=0.1, 
                        strName="Trapezoid_1", 
                        iPartColor=7697908)
JPT.Exec("View Fit To Model()")
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.005, 
                        dMinElemSize=0.005, 
                        dGeomAngle=0.7853981634, 
                        dGeomMinSize=0.0001, 
                        dGradingFactor=0.5, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                    bFMesher=True, 
                    iThreadNum=16)

# Check mesh quality
result = MeshCleanup.ManualCheck.TriQuad(crlTargets=[Part(1)], 
                                        iCheckConditionTri=0, 
                                        dLimitValueTri=0.2, 
                                        iCheckConditionQuad=0, 
                                        dLimitValueQuad=0.1)
if result[0] == 1:
    if result[5] > 0:
        print(f'The number of Tri elements that have stretch error is {result[5]}. max value={result[1]}, min value={result[2]}')
        print(f'The error elements are {result[6]}')
    else:
        print("There is no Tri error element")
    if result[12] > 0:
        print(f'The number of Quad elements that have stretch error is {result[12]}. max value={result[8]}, min value={result[9]}')
        print(f'The error elements are {result[13]}')
    else:
        print("There is no Quad error element")
else:
    print("There is no error element")
