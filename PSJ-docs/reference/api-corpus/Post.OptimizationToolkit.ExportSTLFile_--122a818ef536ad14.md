# Post.OptimizationToolkit.ExportSTLFile()

Post.OptimizationToolkit.ExportSTLFile()

Description​

Output the currently displayed shape as an .stl file based on density threshold values.

Syntax​

Post.OptimizationToolkit.ExportSTLFile(...)

Macro: CmdOptimizeOuterShellExport

Ribbon: Post » OptimizationToolkit » ExportSTLFile

Inputs​

strSTLPath​

A String specifying Output path to save the STL file.

This is a required input.

crlBodies​

A list of Cursor identifying the parts to export.

This is a required input.

dDensityRatio​

A Double specifying Density Ratio used to filter outer shell geometry.

The default value is 0.0.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Import arbitrary topology optimization result
Home.ImportResults.ADVC("C:/Temp/ADVCResult", iImportType=1)

Post.ShowContour(
    crPostJob=TSVPostJob(1), 
    lContourSettings=[
        PostContourSetting(postResultKey=PostResultKey(
            iAnalysisType=11, 
            iResultSet=10, 
            iTimeStep=-1, 
            strResultName="DensityRatio", 
            strResultCompName="DensityRatio", 
            iResultPos=2), 
        postDataOp=PostDataOp(iResultLocation=2, iOptionCoord=1))])
Post.OptimizationToolkit.EnableOptimizationMode()

# Set appropriate density value
Post.OptimizationToolkit.OptimizedShape(dTopologyDensity=0.75)

Post.OptimizationToolkit.ExportSTLFile(strSTLPath="C:/Temp/temp.stl")
