# MeshCleanup.ManualCheck.Tet()

MeshCleanup.ManualCheck.Tet()

Description​

Correct the solid mesh (Tet4/Tet10) according to the selected quality standard.

Syntax​

MeshCleanup.ManualCheck.Tet(...)

Macro:

Ribbon: MeshCleanup » ManualCheck » Tet

Inputs​

crlTargets​

A List of Cursor specifying the targets to check mesh quality. The targets can be part or solid element.

This is a required input.

iElemQualityType​

An Integer specifying the standard method used to check mesh quality.

0: Stretch

1: Aspect Ratio

2: Volume

3: Jacob. Factor

4: Tet Collapse

5: Tet Skew

6: Edge Length

7: Unstable

8: Time Step (Abaqus)

9: Triangle Height

10: Interior Angle

This is a required input.

iCheckCondition​

An Integer specifying the inequality sign for the threshold value.

If iElemQualityType = 0: The default value is 0 (Less than and equal).

If iElemQualityType = 1: The default value is 2 (Greater than and equal).

If iElemQualityType = 2: The default value is 0 (Less than and equal).

If iElemQualityType = 3: The default value is 0 (Less than and equal).

If iElemQualityType = 4: The default value is 0 (Less than and equal).

If iElemQualityType = 5: The default value is 2 (Greater than and equal).

If iElemQualityType = 6: The default value is 0 (Less than and equal).

If iElemQualityType = 7: The default value is 0 (Less than and equal).

If iElemQualityType = 8: The default value is 0 (Less than and equal).

If iElemQualityType = 9: The default value is 0 (Less than and equal).

If iElemQualityType = 10: The default value is 0 (Less than and equal).

dLimitValue​

A Double specifying the threshold value will be used to detect and display the elements violated the specified mesh quality standard.

If iElemQualityType = 0: The default value is 0.1.

If iElemQualityType = 1: The default value is 10.0.

If iElemQualityType = 2: The default value is 0.0.

If iElemQualityType = 3: The default value is 0.0.

If iElemQualityType = 4: The default value is 0.05.

If iElemQualityType = 5: The default value is 0.9

If iElemQualityType = 6: The default value is 0.1.

If iElemQualityType = 7: The default value is 2.0.

If iElemQualityType = 8: The default value is 1.0E-10.

If iElemQualityType = 9: The default value is 0.1.

If iElemQualityType = 10: The default value is 10.

dSafetyFactor​

A Double specifying the safety factor value of elements to be displayed. This argument is used when iElementQualityType = 8, 9, or 10.

The default value is 1.0.

Return Code​

A Tuple specifying 8 values of mesh quality check in order.

Succeeded(1) or Failed(0)

Cutoff value (Minimum)

Cutoff value (Maximum)

Cutoff value (Average)

Number of measured elements.

Number of error elements.

A list of ID error elements.

A list of error element edges.

Sample Code​

# Prepare model
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.0001], 
                ilAxialNodes=[10, 10, 2], 
                strName="Cube_1", 
                iPartColor=13259210)

Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.1, 
                        dGeomAngle=0.7853981634, 
                        dMinStretchVal=0.0, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0))

Meshing.SolidMeshing(crlParts=[Part(1)], 
                    bTet10=True, 
                    dGradingFactor=1.0, 
                    iSpeedVsQual=1, 
                    bSafeMode=False, 
                    iParallel=8, 
                    bSurfaceNodes=False, 
                    bEdgeNodes=False, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

# Check mesh quality
result = MeshCleanup.ManualCheck.Tet(crlTargets=[Part(1)], iCheckCondition=0, dLimitValue=0.1)
(success_flag,min,max,avg,target_num,error_num,errors1,errors2) = result
if result[0] == 1:
    print(f'The number of elements that have stretch error is {error_num}. max value={max}, min value={min}')
    print(f'The error elements are {errors1}')
else:
    print("There is no error element")
