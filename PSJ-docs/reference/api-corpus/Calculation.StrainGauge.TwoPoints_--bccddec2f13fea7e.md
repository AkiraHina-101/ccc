# Calculation.StrainGauge.TwoPoints()

Calculation.StrainGauge.TwoPoints()

Description​

Display stress and strain in the direction connecting two points.

Syntax​

Calculation.StrainGauge.TwoPoints(...)

Macro: CmdAddStrainGauge2Nodes

Ribbon: Calculation » StrainGauge » TwoPoints

Inputs​

iNodeID​

An Integer specifying the ID of the 1st selected node. This argument can be used for both 2Nodes or Node-Point selection methods.

The default value is 0.

iNodeID2​

An Integer specifying the ID of the 2nd selected node. This argument was used incase of the selection method is 2Nodes.

The default value is 0.

dlPosition​

A Double List specifying the coordinate of the selected Point. This argument was used incase of the selection method is Node-Point.

The default value is [0.0,0.0,0.0].

dWidth​

A Double specifying the width of the selection when the node is picked.

The default value is 0.0.

dLength​

A Double specifying the length of the selection when the node is picked.

The default value is 0.0.

dAmendFactor​

A Double specifying the coefficient for correction that is used for strain analysis results.

The default value is 1.0.

strGaugeName​

A String specifying the gauge name.

The default value is "".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Plot the result
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=2, 
                strResultName="Strain", 
                strResultCompName="Solid Max Principal Strain", 
                iResultPos=4), 
                postDataOp=PostDataOp(iResultLocation=1, 
                iOptionCoord=1, 
                iOptionConversion=1, 
                iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=2,
                    strResultName="Strain", 
                    strResultCompName="Solid Max Principal Strain"))

# StrainGauge > TwoPoints
Calculation.StrainGauge.TwoPoints(iNodeID=110, iNodeID2=111, dWidth=0.005, dLength=0.01)
