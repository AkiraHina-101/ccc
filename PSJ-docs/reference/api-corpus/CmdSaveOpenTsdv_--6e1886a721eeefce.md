# CmdSaveOpenTsdv()

CmdSaveOpenTsdv()

Description​

Save / Load calculation results in Post Tools Window into / from csv file.

Syntax​

CmdSaveOpenTsdv(string fileName, bool SaveLoad, cursor[] calculations, bool bdfMode)

Inputs​

1. string ​

Save / Load file path.

2. bool ​

Save or Load. 0: save, 1: load.

3. cursor[] ​

Target calculations.

4. bool ​

Specifying the condition to read/write the load in bdf or normal format.

Return Code​

Nothing.

Sample Code​

CmdSaveOpenTsdv("C:/Temp/frequency.tsdv", 0, [195:1, 195:2], 0)
