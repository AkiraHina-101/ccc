# MC_Mesh_Quality_Manual_Check_TriQuad()

MC_Mesh_Quality_Manual_Check_TriQuad()

Description​

Correct the surface mesh (TRI3/TRI6/QUAD4/QUAD8) according to the selected quality standard.

Syntax​

MC_Mesh_Quality_Manual_Check_TriQuad(Cursor[] targetBody, Cursor[] targetFace,
    Cursor[] targetElements, int nElemType, int nElemQuality, int nCheckConditionTri,
    double dLimitValueTri, double TSSFACTri, int nCheckConditionQuad, dLimitValueQuad,
    double TSSFACQuad, bool bIncludeDiagobalQuad, int nNonPrimary)

Inputs​

1. Cursor[]​

Part Cursor([3:Part ID])

2. Cursor[]​

Face Cursor([6:Face ID])

3. Cursor[]​

Element Cursor([11:Element ID])

4. Int​

Elements type, default elements TriQuad = 4

5. Int​

Elemenets Quality: Stretch = 0, Aspect Ratio = 1, Edge Length = 2, Area = 3. Node Valence = 4, Interior Angle = 5, Unstable = 6, Time Step (LS-Dyna) = 7, Time Step (Abaqus) = 8

6. Int​

Check condition Tri "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

7. Double​

Limit value Tri

8. Double​

TSSFAC tri value

9. Int​

Check condition Quad "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

10. Double​

Limit value for Quad

11. Double​

TSSFAC quad value

12. Bool​

Include diagonal flag true = 1, false = 0

13. Bool​

Nonprimary

Return Code​

1. Succeeded(1) or Failed(0).​

2. Cutoff Value (Minimum) (Tri check).​

3. Cutoff Value (Maximum) (Tri check).​

4. Cutoff Value (Average) (Tri check).​

5. Number of measured elements (Tri check).​

6. Number of error elements (Tri check).​

7. A list of error elements (Tri check).​

8. A list of error element edge (Tri check).​

9. Cutoff Value (Minimum) (Quad check).​

10. Cutoff Value (Maximum) (Quad check).​

11. Cutoff Value (Average) (Quad check).​

12. Number of measured elements (Quad check).​

13. Number of error elements (Quad check).​

14. A list of error elements (Quad check).​

15. A list of error element edge (Quad check).​

Sample Code​

Geometry.Part.Trapezoid(
    dlLength=[0.01, 0.001, 0.01], 
    dTopXLength=0.1, 
    strName="Trapezoid_1", 
    iPartColor=7697908)

Meshing.SetMeshAttribute(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.005, 
        dMinElemSize=0.005, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.005, 
        dMinElemSize=0.005, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0), 
    bFMesher=True)

result=JPT.Exec('MC_Mesh_Quality_Manual_Check_TriQuad([3:1], [], [], 4, 2, 0, 0.0001, 1, 0, 0.0001, 1, 1, 0)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    print(f'The number of tri elements that have Edge Length error is {splitted[5]}. max value={splitted[2]}, min value={splitted[1]}')
    print(f'The number of quad elements that have Edge Length error is {splitted[12]}. max value={splitted[9]}, min value={splitted[8]}')
