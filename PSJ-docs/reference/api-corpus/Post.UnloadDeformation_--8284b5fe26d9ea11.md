# Post.UnloadDeformation()

Post.UnloadDeformation()

Description​

Hide deformation from current result.

Syntax​

Post.UnloadDeformation(...)

Macro: CmdResetPostDeformation()

Ribbon: Post » UnloadDeformation

Inputs​

This utility function does not require any input value.

Return Code​

True if success, or False if failed.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath)

# Load contour
Post.ShowContour(
    crPostJob=TSVPostJob(1), 
    lContourSettings=[
        PostContourSetting(
            postResultKey=PostResultKey(
                iAnalysisType=1, iResultSet=1, iTimeStep=1, strResultName="Displacement", 
                strResultCompName="Translational", iResultPos=1), 
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])

Post.ShowDeformation(
    crPostJob=TSVPostJob(1), 
    postResultKey=PostResultKey(
        iAnalysisType=1, 
        iResultSet=1, 
        iTimeStep=1, 
        strResultName="Displacement", 
        strResultCompName="Translational"))
Post.EnableMiddleNodes()

# Hide deformation from model
Post.UnloadDeformation()
