# Calculation.StrainGauge.AxisWithAngle()

Calculation.StrainGauge.AxisWithAngle()

Description​

Display stress/strain data for an input rotation angle from the first defined axis on a plane consisting of two axes.

Syntax​

Calculation.StrainGauge.AxisWithAngle(...)

Macro: CmdAddStrainGaugeAxisAngle

Ribbon: Calculation » StrainGauge » AxisWithAngle

Inputs​

ilNodeIDs​

A List of Integer specifying the IDs of the selected nodes.

The default value is [].

iAxis1​

An Integer specifying the first axis from maximum principal stress, minimum principal stress, and middle principal stress.

The default value is 0.

iAxis2​

An Integer specifying the second axis from the minimum principal stress and the middle principal stress.

The default value is 1.

dAngle​

A Double specifying the value of rotation angle.

The default value is 0.0.

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

# StrainGauge > AxisWithAngle
Calculation.StrainGauge.AxisWithAngle(ilNodeIDs=[110, 113], dAngle=30.0, dWidth=0.005, dLength=0.01)
