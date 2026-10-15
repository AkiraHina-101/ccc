# Home.ImportCAD.Parasolid()

Home.ImportCAD.Parasolid()

Description​

Import a parasolid file (*.x_t) to the Jupiter Database.

Syntax​

Home.ImportCAD.Parasolid(...)

Ribbon: Home » Import CAD » Parasolid

Inputs​

strlPaths​

A List of String specifying a list of the parasolid files (*.x_t files) which will be used for importing.

This is a required input.

dChordHeightTolerance​

A Double specifying the maximum distance from the actual surface to the facet face. The smaller the Chord Height, the smaller the facets the more accurate the curvature of the surface is represented.

The default value is 0.0.

dAngleToleranceDegree​

A Double specifying the angle tolerance which influences the tessellation of curves with relatively small radii in comparison to the overall size of the CAD model.

The default value is 7.0.

dSurfacePlaneTolerance​

A Double specifying the maximum divergence distance when converting the original surface into a facet face.

The default value is 0.0.

dSurfacePlaneAngle​

A Double specifying the maintained areas with the setting angles larger than the angle between facets face of the geometry.

The default value is 20.0.

dMaxFacetWidth​

A Double specifying the maximum size of a single facet edge.

The default value is 0.1.

dMinFacetWidth​

A Double specifying the minimum size of a single facet edge.

The default value is 0.0.

dScale​

A Double specifying the unit ratio imported from the file's unit into the document's unit.

The default value is 0.001.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The parasolid file (*.x_t file) is imported successfully.

False: The parasolid file (*.x_t file) cannot be imported.

Sample Code​

imported_status = Home.ImportCAD.Parasolid(strlPaths=[JPT.GetProgramPath() +
                                                      "SampleData/CAD_Model/Parasolid/BWM_GRABCAD.x_t"],
                                           dAngleToleranceDegree=7.0,
                                           dScale=0.001)
JPT.Debugger(imported_status)
