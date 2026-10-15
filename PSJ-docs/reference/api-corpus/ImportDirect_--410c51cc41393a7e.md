# ImportDirect()

ImportDirect()

Description​

Import Direct

Syntax​

ImportDirect(string[] strFiles, double dChordHeightTol, double dChordAngleTol,
    bool nConvertIsolatedCurve, double dSurfacePlaneTol, double dSurfacePlaneAngle,
    double dMaxFacetWidth, double dMinFacetWidth, bool nICADFlag, int VRMLColorGroups,
    double dScale)

Inputs​

1. String[]​

Multiple CAD Files

2. Double​

Chord Height Tolerance

3. Double​

Chord Angle Tolerance in degree

4. Bool​

Convert Isolated curve on or off flag true=1, false=0

5. Double​

Surface Plane Tolerance

6. Double​

Surface Plane Angle Tolerance in degree

7. Double​

Max Facet width

8. Double​

Min Facet width

9. Bool​

iCAD flag (true=1, false=0)

10. Int​

VRML Color groups

11. Double​

Scale value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportDirect(["D:/Test.x_t"], 0, 7, 0, 0, 20, 0.1, 0, 0, 0, 0.001)
