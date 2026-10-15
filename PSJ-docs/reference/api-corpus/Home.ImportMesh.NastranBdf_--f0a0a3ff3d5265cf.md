# Home.ImportMesh.NastranBdf()

Home.ImportMesh.NastranBdf()

Description​

Import a Nastran file (*.bdf) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.NastranBdf(...)

Macro: ImportBdf

Ribbon: Home » ImportMesh » NastranBdf

Inputs​

strlPaths​

A List of String specifying a list of the Nastran files (*.bdf files) which will be used for importing.

This is a required input.

iImportType​

An Integer specifying the import type:
0: Standard Nastran BDF - Import the BDF model geometry only.

1: Standard Nastran BDF by Property with 1D2D3D-Part - Import the BDF model geometry and material property. All material parts are applied to each part.

2: Standard Nastran BDF by Property with 1D-Edge,2D-Face,3D-Part - Import the BDF model geometry and material property. Parts are created for each material property. The 1D, 2D material properties are applied to edges or faces of a single part. 3D material properties are applied to each part. (Hollow 1D material properties are applied to each part.)

The default value is 2.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0.

bReadNameComment​

A Boolean specifying the option that read name comments for Jupiter.

The default value is False.

iCreateDup1DElemAnswer​

An Integer specifying the option that creating duplicated 1D element.
-1: Unknown

0: No

1: yes

The default value is -1.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Nastran file (*.bdf file) is imported successfully.

False: The Nastran file (*.bdf file) cannot be imported.

Sample Code​

from os import environ

nastran_file_path = environ["Temp"] + "/TechnoStar/Exported_Nastran_File_EXPORT_BDF.bdf"

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

Analysis.Nastran.LinearStatic(nastranAnalysis=NASTRAN_ANALYSIS(iSolverType=1,
                                                               iGridFormatType=1,
                                                               bDeleteFloatingNodes=True,
                                                               dEpsilon=DFLT_DBL,
                                                               iMaxNumOfIter=DFLT_INT,
                                                               iMemory=DFLT_INT,
                                                               iNcpu=1,
                                                               iSolNo=101,
                                                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueBcresults=DFLT_INT,
                                                                                                           iValueBgresults=DFLT_INT,
                                                                                                           iTypeStrain=0),
                                                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True)),
                              iDummyPropMaterialID=1,
                              strPath=nastran_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportMesh.AnsysDat(strlPaths=[nastran_file_path])
JPT.Debugger(import_status)
