# Home.ExportVTFx()

Home.ExportVTFx()

Description​

Export Geometry information or Geometry and Result information for the active document in Web Viewer format(*.vtfx).

Syntax​

Home.ExportVTFx(...)

Macro: ExportVTFxFile

Ribbon: Home » ExportVTFx

Inputs​

strPath​

A String specifying the file path to be exported.

The default value is "".

iModelType​

An Integer specifying the exporting model type.

0: Pre - Export only geometry

1: Post - Export geometry and selected result

The default value is 1.

bExcludeBarPart​

A Boolean specifying whether to exclude the bar parts when exporting.

The default value is False.

bSurfaceElementOnly​

A Boolean specifying not to export the 3D elements or result on 3D elements.

The default value is False.

iData2D​

An Integer specifying the result position of 2D shell.

0: Top

1: Bottom

3: Average

The default value is 0.

lSelectedResults​

A List of POST_STEP_ITEM specifying the information of the selected result.

The default value is [].

bDisplayPostAddTrescaStress​

A Boolean specifying whether to display post add Tresca stress.

The default value is False.

iCurUnitLength​

An Integer specifying the current unit of length.

The default value is 0.

iCurUnitTime​

An Integer specifying the current unit of length.

The default value is 0.

iCurUnitMass​

An Integer specifying the current unit of mass.

The default value is 0.

iCurUnitForce​

An Integer specifying the current unit of force.

The default value is 0.

iCurUnitAngle​

An Integer specifying the current unit of angle.

The default value is 1.

iCurUnitTemperature​

An Integer specifying the current unit of temperature.

The default value is 1.

bSetDefaultResult​

A Boolean specifying whether to set the default result.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# Export VTFx
exportFile = Home.ExportVTFx(strPath="C:/temp/ExportVTFX.vtfx", 
                            iModelType=1, 
                            bExcludeBarPart=True, 
                            iData2D=1, 
                            lSelectedResults=[PostResultKey(
                                iAnalysisType=1, 
                                iResultSet=1, 
                                iTimeStep=1, 
                                iResultType=6, 
                                strResultName="Displacement", 
                                strResultCompName="Translational", 
                                iResultPos=1)], 
                            bDisplayPostAddTrescaStress=True, 
                            iCurUnitAngle=0, 
                            iCurUnitTemperature=0)
JPT.Debugger(exportFile)
