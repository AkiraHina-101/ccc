# Calculation.AcousticAnalysis.TransmissionLoss.PCHResult()

Calculation.AcousticAnalysis.TransmissionLoss.PCHResult()

Description​

Read a Punch file (*.pch) containing information on the coupled surfaces output from a Nastran structural-acoustic coupled calculation and create a nodal group on the acoustic model.

Syntax​

Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(...)

Macro: AcousticTLPCHResult

Ribbon: Calculation » AcousticAnalysis » TransmissionLoss » PCHResult

Inputs​

strPath​

A String specifying the path of (*.pch) file.

This is a required input.

Return Code​

A Cursor specifying the created PHC result.

Sample Code​

# Please set path to your sample Nastran Vibro-Acoustic file and Punch file.
ResultFile="C:/Temp/Sample.op2"
PunchFile="C:/Temp/PunchSample.pch"

# Prepare result model
Home.ImportResults.Nastran(strPath=ResultFile, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# PCH result
PCHResult = Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(strPath=PunchFile)
JPT.Debugger(PCHResult)
