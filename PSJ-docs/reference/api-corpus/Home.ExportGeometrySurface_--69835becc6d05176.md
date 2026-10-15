# Home.ExportGeometrySurface()

Home.ExportGeometrySurface()

Description​

Export the file in Geometry Surface for Post format (*.stl)

Syntax​

Home.ExportGeometrySurface(...)

Macro: PostExportGeom

Ribbon: Home » ExportGeometrySurface

Inputs​

strFolderName​

A String specifying the path of folder.

This is a required input.

bUseUnit​

A Boolean specifying whether to use unit when exporting.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# Export Geometry Surface for Post
exportFile = Home.ExportGeometrySurface(strFolderName="C:\\temp")
JPT.Debugger(exportFile)
