# Post.OptimizationToolkit.OptimizedShape()

Post.OptimizationToolkit.OptimizedShape()

Description​

Enable the shape display function based on nodal density ratio or density ratio.

Syntax​

Post.OptimizationToolkit.OptimizedShape(...)

Macro: SetHidingElementFactor

Ribbon: Post » OptimizationToolkit » OptimizedShape

Inputs​

dTopologyDensity​

A Double specifying the threshold value for topology density.

The default value is 0.0.

strOption​

A String specifying the method option for hiding factor computation.

The default value is "NodalDensityRatio".

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
