# Home.ImportMesh.Abaqus()

Home.ImportMesh.Abaqus()

Description​

Import an Abaqus file (*.inp) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.Abaqus(...)

Macro: ImportInp

Ribbon: Home » ImportMesh » Abaqus

Inputs​

strlPaths​

A List of String specifying a list of the Abaqus files (*.inp files) which will be used for importing.

This is a required input.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division. Define a face by creating an edge between adjacent elements with an angle smaller than the specified value.

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division. Divide an edge by creating a vertex on adjacent edge elements with an angle smaller than the specified value.

The default value is 60.0.

iImportType​

An Integer specifying the import type.

0: Standard Abaqus Inp - Import the model geometry only.

1: Standard Abaqus Inp by Property - Import the model geometry and material property. A body is created for each material property.

The default value is 1.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Abaqus file (*.inp file) is imported successfully.

False: The Abaqus file (*.inp file) cannot be imported.

Sample Code​

from os import environ

abaqus_file_path = environ["Temp"] + "/TechnoStar/Exported_Abaqus_File_EXPORT_INP.inp"

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

JPT.Exec('CreateAbaqusJob("Job_1", 0, 0, 0, 0, 1, 0, "", \
                          [], 0:0, [], 0, 1, 0, 0, 1, 22:1, 1, 0, 0, 0)')

Analysis.ExportAbaqus(crAbaJob=AbaqusJob(1),
                      strInpPath=abaqus_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportMesh.Abaqus(strlPaths=[abaqus_file_path],
                                          dFaceAngle=3.000001285727965,
                                          dEdgeAngle=3.000001285727965,
                                          iImportType=0)
JPT.Debugger(import_status)
