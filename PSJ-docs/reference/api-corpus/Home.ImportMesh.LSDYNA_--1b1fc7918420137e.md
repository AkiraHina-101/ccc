# Home.ImportMesh.LSDYNA()

Home.ImportMesh.LSDYNA()

Description​

Import an Ls-Dyna file (*.k) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.LSDYNA(...)

Macro: ImportLsDyna

Ribbon: Home » ImportMesh » LSDYNA

Inputs​

strlPaths​

A List of String specifying a list of the Ls-Dyna files (*.k files) which will be used for importing.

This is a required input.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division. Define a face by creating an edge between adjacent elements with an angle smaller than the specified value.

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division. Divide an edge by creating a vertex on adjacent edge elements with an angle larger than the specified value.

The default value is 60.0.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Ls-Dyna file (*.k file) is imported successfully.

False: The Ls-Dyna file (*.k file) cannot be imported.

Sample Code​

from os import environ

lsdyna_file_path = environ["Temp"] + "/TechnoStar/Exported_LSDYNA_File_EXPORT_K.k"

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)],
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

BoundaryConditions.FixedConstraint(crlTargets=[Face(24)])
BoundaryConditions.Pressure.General(dPressure=5000000.0,
                                    crlTargets=[Face(23)])

Properties.Material.Add("Stainless_Steel",
                        [Density([(DENSITY, 7.75e-09)]),
                         Elastic([(YOUNGS_MODULUS, 193000.0),
                                  (POISSONS_RATIO, 0.31)])])
Properties.Solid(crlTargets=[Part(1)],
                 strName="Cube_for_testing",
                 iPropertyColor=16131973,
                 crMaterial=Material(1),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)

Analysis.LSDYNAJob()
Analysis.ExportLsdyna(strPath=lsdyna_file_path,
                      crJob=LSDynaJob(1))

JPT.Exec('New Document()')
import_status = Home.ImportMesh.LSDYNA(strlPaths=[lsdyna_file_path])
JPT.Debugger(import_status)
