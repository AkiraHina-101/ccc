# Calculation.AcousticAnalysis.ActranPltImport()

Calculation.AcousticAnalysis.ActranPltImport()

Description​

Create intensity from the sound pressure and particle velocity results.

Syntax​

Calculation.AcousticAnalysis.ActranPltImport(...)

Macro: PostImportActranPlt

Ribbon: Calculation » AcousticAnalysis » ActranPltImport

Inputs​

strPath​

A String specifying the Actran (*.plt) file to be imported.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

#Please set path to your sample actran file.
filePath="C:/Temp/Sample.plt"

plt = Calculation.AcousticAnalysis.ActranPltImport(strPath=filePath)
JPT.Debugger(plt)
