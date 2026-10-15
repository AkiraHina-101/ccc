# ExportWindowSettings()

ExportWindowSettings()

Description​

Export the settings of dockable windows into the .reg file.

Syntax​

ExportWindowSettings(String FilePath)

Inputs​

`1. String​

Export file name (.reg)

Return Code​

This function does not have return value.

Sample Code​

JPT.Exec('ExportWindowSettings("C:/Temp/JupiterWindowSettings.reg")')
