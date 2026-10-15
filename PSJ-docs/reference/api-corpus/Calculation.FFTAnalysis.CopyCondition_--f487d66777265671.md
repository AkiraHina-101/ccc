# Calculation.FFTAnalysis.CopyCondition()

Calculation.FFTAnalysis.CopyCondition()

Description​

Create a copy of the specified FFT condition.

Syntax​

Calculation.FFTAnalysis.CopyCondition(...)

Macro:

Ribbon: Calculation » FFTAnalysis » CopyCondition

Inputs​

crPostFFTCondition​

A Cursor specifying FFT Condition.

This is a required input.

Return Code​

A Boolean specifying whether the function succeeded or not.

True: Succeeded.

False: Failed.

Sample Code​

# This code needs PostFFTCondition by using 
# Calculation.FFTAnalysis.SetCondition. 
# i.e.
# firstBore=Calculation.FFTAnalysis.SetCondition(...)

Calculation.FFTAnalysis.CopyCondition(crPostFFTCondition=firstBore)
