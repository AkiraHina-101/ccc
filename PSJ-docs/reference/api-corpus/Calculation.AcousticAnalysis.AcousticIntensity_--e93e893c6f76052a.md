# Calculation.AcousticAnalysis.AcousticIntensity()

Calculation.AcousticAnalysis.AcousticIntensity()

Description​

Create the intensity from the sound pressure and particle velocity results.

Syntax​

Calculation.AcousticAnalysis.AcousticIntensity(...)

Macro: AcousticIntensity

Ribbon: Calculation » AcousticAnalysis » AcousticIntensity

Inputs​

strName​

A String specifying the name of the target analysis.

The default value is "".

crEdit​

A Cursor specifying an existing Load condition

If this parameter is used, the specified Load condition will be modified.

If it is left None, a new Load condition will be created.

The default value is None.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Please set path to your sample Nastran Vibro-Acoustic file.
filePath="C:/Temp/Sample.op2"

# Prepare result model
Home.ImportResults.Nastran(strPath=filePath, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# AcousticAnalysis.AcousticIntensity
Calculation.AcousticAnalysis.AcousticIntensity(strName="Subcase 201")
