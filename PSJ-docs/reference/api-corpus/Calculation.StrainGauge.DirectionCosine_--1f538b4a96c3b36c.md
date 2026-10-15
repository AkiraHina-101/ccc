# Calculation.StrainGauge.DirectionCosine()

Calculation.StrainGauge.DirectionCosine()

Description​

Display a graph of the stress/strain in the direction cosine of the entered direction vector.

Syntax​

Calculation.StrainGauge.DirectionCosine(...)

Macro: CmdAddStrainGaugeDirCos

Ribbon: Calculation » StrainGauge » DirectionCosine

Inputs​

ilNodeIDs​

A List of Integer specifying the IDs of the selected nodes.

The default value is [].

dlDirectionCosine​

A Double List specifying the direction to get the result.

The default value is [0.0,0.0,1.0].

dWidth​

A Double specifying the width of the selection when the node is picked.

The default value is 0.0.

dLength​

A Double specifying the length of the selection when the node is picked.

The default value is 0.0.

dAmendFactor​

A Double specifying the coefficient for correction that is used for strain analysis results

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
                postDataOp=PostDataOp(
                iResultLocation=1, 
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

# StrainGauge > DirectionCosine
Calculation.StrainGauge.DirectionCosine(ilNodeIDs=[114], dWidth=0.005, dLength=0.01)
