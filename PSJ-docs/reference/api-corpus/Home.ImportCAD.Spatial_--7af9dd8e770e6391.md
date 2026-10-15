# Home.ImportCAD.Spatial()

Home.ImportCAD.Spatial()

Description​

Import a CAD file by using Spatial interface to the Jupiter Database.

Syntax​

Home.ImportCAD.Spatial(...)

Macro: ImportSpatial

Ribbon: Home » ImportCAD » Spatial

Inputs​

strlPaths​

A List of String specifying a list of the CAD files which will be used for importing.

This is a required input.

dSurfacePlaneTolerance​

A Double specifying the maximum divergence distance when converting the original surface into a facet plane.

The default value is 0.0.

dSurfacePlaneAngle​

A Double specifying the maintain areas with setting angles larger than the angle between facets of the surface plane of the geometry.

The default value is 20.0.

dMaxFacetWidth​

A Double specifying the maximum size of a single facet edge.

The default value is 1000.0.

bNXMultipart​

A Boolean enable/disable the configure of the multi-body reading settings.
On: Load multi-body into one part.

Off: Separate the multi-body into parts and load it under the sub-assembly.

The default value is True.

bHealing​

A Boolean enable/disable the healing function.

The default value is True.

bSetFaceColor​

A Boolean enable/disable using color information.

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The CAD file (IGES file, STEP file, etc.) is imported successfully.

False: The CAD file (IGES file, STEP file, etc.) cannot be imported.

Sample Code​

imported_status = Home.ImportCAD.Spatial(strlPaths=[JPT.GetProgramPath() +
                                                    "SampleData/CAD_Model/IGES/A400MA.igs"],
                                         bSetFaceColor=True)
JPT.Debugger(imported_status)
