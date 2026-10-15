# Post.OptimizationToolkit.OptimizedShapeSmooth()

Post.OptimizationToolkit.OptimizedShapeSmooth()

Description​

Create iso-surfaces (smoothing) based on nodal density and element density within optimization results, and convert them into a mesh.

Syntax​

Post.OptimizationToolkit.OptimizedShapeSmooth(...)

Macro: CmdOptimizeShapeSmoothFunc

Ribbon: Post » OptimizationToolkit » OptimizedShapeSmooth

Inputs​

crlDesignedParts​

A List of Cursor specifying designed parts.

This is a required input.

crlNonDesignedParts​

A List of Cursor specifying non-designed parts.

The default value is [].

dDensityRatio​

A Double specifying threshold density ratio to filter regions.

The default value is 0.0.

bKeepSharedNodeOnBody​

A Boolean specifying whether to keep shared nodes on body interface.

The default value is False.

iCycle​

An Integer specifying the number of smoothing cycles.

The default value is 50.

dFactor​

A Double specifying the smoothing intensity factor.

The default value is 0.3.

dMeshSize​

A Double specifying target mesh size for smoothing.

The default value is 3.0.

iRemovedLayers​

An Integer specifying the number of boundary layers to remove.

The default value is 1.

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

# Set appropriate values
Post.OptimizationToolkit.OptimizedShapeSmooth(
    crlDesignedParts=[Part(1)], 
    dDensityRatio=0.75, 
    bKeepSharedNodeOnBody=True, 
    dMeshSize=0.002845)
