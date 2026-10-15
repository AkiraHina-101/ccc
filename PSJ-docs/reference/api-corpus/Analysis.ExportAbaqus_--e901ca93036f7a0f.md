# Analysis.ExportAbaqus()

Analysis.ExportAbaqus()

Description​

Export Abaqus (*.inp) file.

Syntax​

Analysis.ExportAbaqus(...)

Macro: ExportAbaqusInp

Ribbon: Analysis » ExportAbaqus

Inputs​

crAbaJob​

A Cursor specifying the created Abaqus job using Analysis.Abaqus() function.

The default value is None.

crlParts​

A List of Cursor specifying the list of parts will be exported.

The default value is [].

strInpPath​

A String specifying the destination path file to export.

The default value is "".

Return Code​

A Boolean specifying the status of the exporting process:

True: The Abaqus (*.inp) file has been exported successfully.

False: The Abaqus (*.inp) file cannot be exported.

Sample Code​

from os import environ
import re

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

Properties.Material.Add("Concrete",
                        [Density([(DENSITY, 2.3e-09)]),
                        Elastic([(YOUNGS_MODULUS, 30000.0),
                                 (POISSONS_RATIO, 0.18)])])

Properties.Solid(crlTargets=[Part(1)],
                 strName="Solid Property 1",
                 iPropertyColor=16131973,
                 crMaterial=Material(1),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)

BoundaryConditions.FixedConstraint(crlTargets=[Face(24)])
BoundaryConditions.Pressure.General(dPressure=1000000.0,
                                    crlTargets=[Face(21,
                                                     23)])

Analysis.AbaqusStep.StaticStep(strName="Step1",
                               iAutomatic=1,
                               iMaxInc=100,
                               dInitSize=1.0,
                               dMinSize=1e-05,
                               dMaxSize=1.0,
                               iAllowIter=8,
                               dAdjustFactor=1.0,
                               iMaxContactIteration=30,
                               dDampingFactor=0.0002,
                               iUseAdaptive=1,
                               dMaxRationOfEnergyStrain=0.05,
                               dTimePeriod=1.0,
                               iRamp=1,
                               iExtrapolateMethod=1,
                               strlFullPlasticRegion=[""])

Analysis.Abaqus(strName="Job_1", abaqusAnalysis=JOB_ABAQUS_DATA(iSurfDefType=1,
                iUnit=1, bExportNodeElemGroup=True, bDeleteFloatingNodes=True, bExportFaceElemGroup=True,
                bLoadCase=True, crDummyMat=Material(1)))
export_status = Analysis.ExportAbaqus(crAbaJob=AbaqusJob(1),
                                      strInpPath=re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                 "/TechnoStar/Example_Export_Abaqus_PSJ_Command.inp")

print("Exported to INP file successfully!") \
    if export_status == True \
    else print("Error is occurred! Can't export INP file")
