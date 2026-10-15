# Post.ShowContour()

Post.ShowContour()

Description​

Load result on model and show contour.

Syntax​

Post.ShowContour(...)

Macro: CmdShowPostContour

Ribbon: Post » ShowContour

Inputs​

crPostJob​

A Cursor specifying the Post job result (post data).

This is a required input.

lContourSettings​

A list of POST_CONTOUR_SETTINGS specifying the setting for contour of 1st result (required) and 2 additional results (optional).

This is a required input.

bEnableMidNode​

A Boolean specifying whether or not enable result option.

The default value is False.

bApplyAll​

A Boolean specifying whether or not apply above settings to all active Post documents.

The default value is False.

Return Code​

A Boolean specifying if the contour can be showed or not.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath)

# Show contour
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
