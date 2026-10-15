# Home.ExportPV()

Home.ExportPV()

Description​

Output the results to PV files according to three types of elements, or materials, or properties.

Syntax​

Home.ExportPV(...)

Macro: Export_Post_Viewer_File

Ribbon: Home » ExportPV

Inputs​

iGroupType​

An Integer specifying the type of output group.

0: None

1: Specify the element created in the group

2: Specify the material created in the group

3: Specify the property created in the group

The default value is 0.

strFileName​

A String specifying the file path to be exported.

The default value is "".

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(
                    postResultKey=PostResultKey(
                        iAnalysisType=1, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Displacement", 
                        strResultCompName="Translational", 
                        iResultPos=1), 
                    postDataOp=PostDataOp(
                        iResultLocation=1, 
                        iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                        iAnalysisType=1, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Displacement", 
                        strResultCompName="Translational"))
Tools.Group.CreateGroup(strGroupName="Element3DGroup", crlTargets=[ROElem(479, 477, 480, 478)])

# Export PV
exportFile = Home.ExportPV(iGroupType=1, strFileName="C:/temp/ExportPV.tsv")
JPT.Debugger(exportFile)
