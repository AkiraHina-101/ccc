# Post.OptimizationToolkit.EnableOptimizationMode()

Post.OptimizationToolkit.EnableOptimizationMode()

Description​

Enable the shape display function based on nodal density ratio or density ratio.

Syntax​

Post.OptimizationToolkit.EnableOptimizationMode(...)

Macro: EnableOptimizationRenderMode

Ribbon: Post » OptimizationToolkit » EnableOptimizationMode

Inputs​

bOptimizationMode​

A Boolean specifying whether or not enables optimization mode.

The default value is True.

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

Post.OptimizationToolkit.OptimizedShape(dTopologyDensity=0.75)
