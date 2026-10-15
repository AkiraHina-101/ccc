# Home.ImportCAD.ProECreoDirect()

Home.ImportCAD.ProECreoDirect()

Description​

This method imports an assembly from a Pro Engineer/Creo file by Direct interface into the root assembly.

Syntax​

Home.ImportCAD.ProECreoDirect(...)

Ribbon: Home » ImportCAD » ProECreoDirect

Inputs​

strlPaths​

A List of String specifying the list of the paths of the CAD files.

This is a required input.

dChordHeightTolerance​

A Double specifying the maximum distance from the actual surface to the facet face.
The smaller the Chord Height, the smaller the facets the more accurate the curvature of the surface is represented.

The default value is 0.0.

dAngleToleranceDegree​

A Double specifying the angle tolerance which influences the tessellation of curves with relatively small radii in comparison to the overall size of the CAD model.

The default value is 0.0.

dMaxFaceWidth​

A Double specifying the maximum value for the maximum face width used for surface tessellation.

The default value is 0.1.

Return Code​

A String of 1 if succeed, or 0 if fail.

Sample Code​

Home.ImportCAD.ProECreoDirect(strlPaths=[JPT.GetProgramPath() + "SampleData\\CAD_Model\\ProECreoDirect_File.prt"],
    dMaxFacetWidth=100.0)
