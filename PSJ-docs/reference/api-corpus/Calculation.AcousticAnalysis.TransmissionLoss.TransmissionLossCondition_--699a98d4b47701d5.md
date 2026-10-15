# Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition()

Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition()

Description​

Calculate AC power and transmittance from the selected nodal groups created by importing the PCH file on input side and output side respectively.

Syntax​

Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition(...)

Macro: AcousticTLCondition

Ribbon: Calculation » AcousticAnalysis » TransmissionLoss » TransmissionLossCondition

Inputs​

crGroupIn​

A Cursor specifying the nodal group of input data.

The default value is None.

crGroupOut​

A Cursor specifying the nodal group of output data.

The default value is None.

crEdit​

A Cursor specifying an existing  transmission loss condition

If this parameter is used, the specified  transmission loss condition will be modified.

If it is left None, a new  transmission loss condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created transmission loss condition.

Sample Code​

# Please set path to your sample Nastran Vibro-Acoustic file and Punch file.
ResultFile="C:/Temp/Sample.op2"
PunchFile="C:/Temp/PunchSample.pch"

# Prepare result model
Home.ImportResults.Nastran(strPath=ResultFile, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# TransmissionLossCondition
Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(strPath=PunchFile)
condition = Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition(crGroupIn=Group(1), 
                                                                                    crGroupOut=Group(2))
JPT.Debugger(condition)
