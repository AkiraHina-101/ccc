# Home.ImportMesh.Ansys()

Home.ImportMesh.Ansys()

Description​

Import an Ansys file (*.dat) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.Ansys(...)

Macro: ImportAnsys

Ribbon: Home » ImportMesh » Ansys

Inputs​

strlPaths​

A List of String specifying a list of the Ansys files (*.dat files) which will be used for importing.

This is a required input.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Ansys file (*.dat file) is imported successfully.

False: The Ansys file (*.dat file) cannot be imported.

Sample Code​

from os import environ

ansys_file_path = environ["Temp"] + "/TechnoStar/Exported_Ansys_File_EXPORT_DAT.dat"

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

Analysis.Ansys.LinearStatic("Job1",
                            ansysAnalysisBasic=BASIC(dTimeStepSize=1.0,
                                                     dMinTimeStep=1.0),
                            iLoadCaseId=1,
                            strFileName=ansys_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportMesh.Ansys(strlPaths=[ansys_file_path])
JPT.Debugger(import_status)
