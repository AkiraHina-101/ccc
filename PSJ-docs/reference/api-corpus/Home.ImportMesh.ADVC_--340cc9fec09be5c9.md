# Home.ImportMesh.ADVC()

Home.ImportMesh.ADVC()

Description​

Import an ADVC file (*.adx) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.ADVC(...)

Macro: ImportAdxList

Ribbon: Home » ImportMesh » ADVC

Inputs​

strlPaths​

A List of String specifying a list of the ADVC files (*.adx files) which will be used for importing.

This is a required input.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0.

bReadCommentsForJupiter​

A Bool specifying whether Jupiter enables to read Material, Property, LBC, Contact, Job name, and related group names.

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The ADVC file (*.adx file) is imported successfully.

False: The ADVC file (*.adx file) cannot be imported.

Sample Code​

from os import environ

advc_file_path = environ["Temp"] + "/TechnoStar/Exported_ADVC_File_EXPORT_ADX.adx"

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

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, \
                            -1, -1, 2147483647, -1, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 0, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            2147483647, 2147483647, 1.79769e+308, 2147483647, 0, -1, \
                            2147483647, 2147483647, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 0, 1.79769e+308, \
                            1.79769e+308, 0, 0, 2147483647, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 0, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 0:0, \
                            [], [], [], [], -1, "", [], "", 2147483647)')

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, -1, \
                            -1, 2147483647, -1, 2147483647, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 2147483647, 0, -1, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 2147483647, 0, 1.79769e+308, 1.79769e+308, \
                            0, 0, 2147483647, 2147483647, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 119:1, \
                            [(37:1, 0:0, 1), (40:1, 0:0, 1)], [], [], [], -1, "", [], "", 2147483647)')

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, -1, -1, \
                            2147483647, -1, 2147483647, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 2147483647, 0, -1, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 2147483647, 0, 1.79769e+308, 1.79769e+308, \
                            0, 0, 2147483647, 2147483647, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 119:1, [], [], [], [], \
                            -1, "", [], "", 2147483647)')

JPT.Exec('ADVC_Structure("Job_1", "", 0, [119:1], [], [], 0, 0:0, 0, 0, 0, 0, 0, 0, 0, \
                         [3:1], 1, 1, 1, 1, 0, 1, 22:1, 0, "", 2147483647, 2147483647, \
                         0, 1, [], 0, 0, {}, 0, 10, 10, 1, 0, "", 1)'.format(advc_file_path))

JPT.Exec('New Document()')
import_status = Home.ImportMesh.ADVCADX(strlPaths=[advc_file_path])
JPT.Debugger(import_status)
