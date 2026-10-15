# Post.ShowDeformation()

Post.ShowDeformation()

Description​

Load deformation on the model.

Syntax​

Post.ShowDeformation(...)

Macro: CmdShowPostDeformation

Ribbon: Post » ShowDeformation

Inputs​

crPostJob​

A Cursor specifying the Post job result (post data).

This is a required input.

postResultKey​

A POST_RESULT_KEY specifying result to show deformation.

This is a required input.

postDataOption​

A PostDataOp specifying result options.

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
                iAnalysisType=1, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
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
