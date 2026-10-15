# ImportSpatial()

ImportSpatial()

Description​

Import CAD file by Spatial interface

Syntax​

ImportSpatial(string[] vecPath, double surface_plane_tolerance, double suface_plane_angle,
    double max_facet_width, int NX_multibody, int healing, int isNXDirect, int setFaceColor,
    String facetParamCsvFile)

Inputs​

1. String[]​

Multiple CAD file paths

2. Double​

Surface plane tolerance option

3. Double​

Suface plane angle option

4. Double​

Max facet width option

5. Int​

Flag of NX Multibody

6. Int​

Flag of healing option

7. Int​

Flag of NXDirect

8. Int​

Flag of setting face color option

9. String​

Facet parameter csv file path

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportSpatial(["D:/Test.sat"], 0, 20, 0.1, 1, 1, 0, 1, "")
